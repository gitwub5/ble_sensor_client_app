import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:bluetooth_app/core/bluetooth/services/state_service.dart';
import 'package:bluetooth_app/core/bluetooth/utils/ble_uuid.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart' as fb;

class BluetoothConnectionService {
  final BluetoothStateService _bluetoothStateService;
  final BleUUID _bleUUID;
  fb.BluetoothDevice? _connectedDevice;
  StreamSubscription<fb.BluetoothConnectionState>? _connectionSubscription;
  StreamSubscription<List<int>>? _txSubscription;

  final Map<String, fb.BluetoothService> _services = {};
  final Map<String, fb.BluetoothCharacteristic> _characteristics = {};

  // 데이터 스트림 컨트롤러 추가
  final StreamController<String> _txStreamController =
      StreamController<String>.broadcast();

  Stream<String> get txStream => _txStreamController.stream;

  BluetoothConnectionService(this._bluetoothStateService, this._bleUUID);

  /// 📌 BLE 장치 연결
  Future<void> connectToDevice(fb.BluetoothDevice device,
      {bool autoConnect = false}) async {
    try {
      // 블루투스 활성화 여부 확인 및 자동 활성화 시도
      if (!await _bluetoothStateService.ensureBluetoothIsOn()) {
        print("❌ Bluetooth is OFF. Cannot connect to device.");
        return;
      }

      // 이미 연결된 장치인지 확인 &&  현재 연결 상태를 확인
      if (_connectedDevice != null &&
          _connectedDevice!.remoteId == device.remoteId &&
          await _connectedDevice!.connectionState.first ==
              fb.BluetoothConnectionState.connected) {
        print("⚠️ Device is already connected: ${device.remoteId}");
        return;
      }

      // 장치 연결 시작
      await device.connect(autoConnect: autoConnect);
      _connectedDevice = device;
      print("✅ Connected to ${device.remoteId}");

      await _discoverServices(); // 서비스 검색 및 캐싱
      await _subscribeToTXCharacteristic(); // TX 구독 시작 (데이터 수신)

      // 연결 상태 모니터링 추가 (끊어졌을 때 감지)
      _monitorConnectionState(device);
    } catch (e) {
      print("❌ Connection failed: $e");
      rethrow;
    }
  }

  /// 📌 BLE 장치 연결 해제
  Future<void> disconnectDevice() async {
    if (_connectedDevice != null) {
      print("🔌 Disconnecting from ${_connectedDevice!.remoteId}...");

      final device = _connectedDevice;
      _connectedDevice = null;

      await device!.disconnect();
      await device.connectionState.firstWhere(
          (state) => state == fb.BluetoothConnectionState.disconnected);

      _services.clear();
      _characteristics.clear();
      await _connectionSubscription?.cancel();
      _connectionSubscription = null;

      await _txSubscription?.cancel(); // TX 구독 해제
      _txSubscription = null;

      print("🔌 Disconnected.");
    }
  }

  /// 📌 장치의 서비스 및 특성 UUID 검색 및 저장
  Future<void> _discoverServices() async {
    if (_connectedDevice == null) return;

    try {
      _services.clear();
      _characteristics.clear();

      List<fb.BluetoothService> services =
          await _connectedDevice!.discoverServices();

      for (var service in services) {
        _services[service.uuid.toString()] = service;

        for (var characteristic in service.characteristics) {
          _characteristics[characteristic.uuid.toString()] = characteristic;
          print("🔍 캐싱된 Characteristic: ${characteristic.uuid}");
        }
      }
      print("✅ 모든 서비스 및 특성 저장 완료!");
    } catch (e) {
      print("❌ 서비스 검색 중 오류 발생: $e");
    }
  }

  /// 📌 특정 서비스 UUID로 가져오기
  fb.BluetoothService? getService(String uuid) {
    return _services[uuid];
  }

  /// 📌 특정 캐릭터리스틱 UUID로 가져오기
  fb.BluetoothCharacteristic? getCharacteristic(String uuid) {
    return _characteristics[uuid];
  }

  /// 📌 Read Characteristic (일반적으로 필요 없음 - TX 구독을 대신 사용)
  Future<String?> readCharacteristic() async {
    if (_connectedDevice == null) {
      print("❌ No device connected. Cannot read characteristic.");
      return null;
    }

    // ✅ `BleUUID`에서 TX UUID 사용하도록 변경
    final characteristic = getCharacteristic(_bleUUID.txUuidString);
    if (characteristic == null) {
      print("⚠️ TX Characteristic UUID not found");
      return null;
    }

    if (!characteristic.properties.read) {
      print("❌ Characteristic ${_bleUUID.txUuidString} does not support read.");
      return null;
    }

    try {
      List<int> data = await characteristic.read();
      String receivedData = utf8.decode(data);

      print("📥 Received Data (Read): $receivedData");
      return receivedData;
    } catch (e) {
      print("❌ Failed to read TX characteristic: $e");
      return null;
    }
  }

  /// 📌 TX Characteristic 구독
  Future<void> _subscribeToTXCharacteristic() async {
    final characteristic = getCharacteristic(_bleUUID.txUuidString);
    if (characteristic == null) {
      print("❌ TX Characteristic not found");
      return;
    }

    // 기존 구독 해제
    await _txSubscription?.cancel();
    _txSubscription = characteristic.onValueReceived.listen((data) {
      String receivedData = utf8.decode(data);
      print("📥 Received Data (onValueReceived): $receivedData");

      // 데이터 수신 시 Stream에 추가
      _txStreamController.add(receivedData);
    });

    await characteristic.setNotifyValue(true);
    print("🔔 Subscribed to TX Characteristic.");
  }

  /// 📌 Write Characteristic (20바이트 단위로 Split Write)
  Future<bool> writeCharacteristic(String command) async {
    if (_connectedDevice == null) {
      print("❌ No device connected. Cannot write characteristic.");
      return false;
    }

    // ✅ `BleUUID`에서 RX UUID 사용하도록 변경
    final characteristic = getCharacteristic(_bleUUID.rxUuidString);
    if (characteristic == null) {
      print("⚠️ RX Characteristic UUID not found");
      return false;
    }

    if (!characteristic.properties.write) {
      print(
          "❌ Characteristic ${_bleUUID.rxUuidString} does not support write.");
      return false;
    }

    try {
      List<int> data = utf8.encode(command);
      int chunkSize = 20;

      await _splitWrite(characteristic, data, chunkSize);

      print("📤 Sent Command: $command (Split Write - 20 Bytes Per Chunk)");
      return true;
    } catch (e) {
      print("❌ Failed to write RX characteristic: $e");
      return false;
    }
  }

  /// 📌 데이터를 **20바이트 단위**로 나누어 전송하는 함수
  Future<void> _splitWrite(fb.BluetoothCharacteristic characteristic,
      List<int> data, int chunkSize) async {
    for (int i = 0; i < data.length; i += chunkSize) {
      List<int> chunk = data.sublist(i, min(i + chunkSize, data.length));
      await characteristic.write(chunk, allowLongWrite: false);
      print("📤 Sent Chunk (${chunk.length} bytes): ${utf8.decode(chunk)}");

      // **20바이트 단위로 나눠서 전송할 때, 안정성을 위해 딜레이 추가**
      await Future.delayed(Duration(milliseconds: 50));
    }
  }

  /// 📌 연결 상태 모니터링 (끊어졌을 때 감지)
  void _monitorConnectionState(fb.BluetoothDevice device) {
    _connectionSubscription?.cancel(); // ✅ 기존 리스너 제거

    _connectionSubscription = device.connectionState.listen((state) async {
      print("📡 Connection State Changed: $state");

      if (state == fb.BluetoothConnectionState.disconnected) {
        print("⚠️ Device Disconnected: ${device.remoteId}");
        print(
            "🔍 Reason: ${device.disconnectReason?.code} - ${device.disconnectReason?.description}");

        _connectedDevice = null;
        _services.clear();
        _characteristics.clear();
      }
    });

    // ✅ disconnect 시 자동으로 구독 해제
    device.cancelWhenDisconnected(_connectionSubscription!,
        delayed: true, next: true);
  }

  /// 📌 서비스 해제
  void dispose() {
    _connectionSubscription?.cancel();
    _connectionSubscription = null;
    _txSubscription?.cancel();
    _txStreamController.close();
    _services.clear();
    _characteristics.clear();
  }
}
