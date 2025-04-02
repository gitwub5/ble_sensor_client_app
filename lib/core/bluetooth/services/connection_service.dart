import 'dart:async';
import 'dart:convert';
import 'package:bluetooth_app/core/bluetooth/services/state_service.dart';
import 'package:bluetooth_app/core/bluetooth/utils/ble_uuid.dart';
import 'package:bluetooth_app/shared/enums/command_type.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart' as fb;

class BluetoothConnectionService {
  final BluetoothStateService _bluetoothStateService;
  final BleUUID _bleUUID;
  fb.BluetoothDevice? _connectedDevice;
  StreamSubscription<fb.BluetoothConnectionState>? _connectionSubscription;
  StreamSubscription<List<int>>? _streamSubscription;

  final Map<String, fb.BluetoothService> _services = {};
  final Map<String, fb.BluetoothCharacteristic> _characteristics = {};

  // 데이터 스트림 컨트롤러 추가
  final StreamController<String> _streamController =
      StreamController<String>.broadcast();

  Stream<String> get stream => _streamController.stream;

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
      await device.connectionState.firstWhere(
          (state) => state == fb.BluetoothConnectionState.connected);

      _connectedDevice = device;
      print("✅ Connected to ${device.remoteId}");

      await _discoverServices(); // 서비스 검색 및 캐싱
      await _subscribeToNotifyCharacteristic(); // 온습도 데이터 구독 시작 (데이터 수신)

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

      await _streamSubscription?.cancel(); // 구독 해제
      _streamSubscription = null;

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

  /// 📌 특정 캐릭터리스틱 UUID로 가져오기
  fb.BluetoothCharacteristic? _getCharacteristic(String uuid) {
    return _characteristics[uuid];
  }

  /// 📌 Read Characteristic (사용 안할 듯)
  Future<void> readCharacteristic() async {
    if (_connectedDevice == null) return print("❌ No device connected.");

    final characteristic = _getCharacteristic(_bleUUID.sensorDataCharString);
    if (characteristic == null)
      return print("⚠️ Sensor characteristic not found.");

    try {
      final data = await characteristic.read();
      final decoded = utf8.decode(data);
      print("📥 Read Triggered, Data Received: $decoded");
      // 리턴 안하게 설정해둠
    } catch (e) {
      print("❌ Read failed: $e");
    }
  }

  /// 📌 Notify Characteristic 구독
  Future<void> _subscribeToNotifyCharacteristic() async {
    final characteristic = _getCharacteristic(_bleUUID.sensorDataCharString);
    if (characteristic == null) {
      print("❌ Characteristic not found");
      return;
    }

    // 기존 구독 해제
    await _streamSubscription?.cancel();
    _streamSubscription = characteristic.onValueReceived.listen((data) {
      String receivedData = utf8.decode(data);
      print("📥 Received Data (onValueReceived): $receivedData");

      // 데이터 수신 시 Stream에 추가
      _streamController.add(receivedData);
    });

    await characteristic.setNotifyValue(true);
    print("🔔 Subscribed to Notify Characteristic.");
  }

  /// 📌 Write Characteristic (단일 Write)
  Future<bool> writeCharacteristic(CommandType command, String message) async {
    if (_connectedDevice == null) {
      print("❌ No device connected. Cannot write characteristic.");
      return false;
    }

    // ✅ command에 따라 UUID 선택
    final String? charUuid = switch (command) {
      CommandType.setting => _bleUUID.settingCharString,
      CommandType.update => _bleUUID.sensorDataCharString,
      _ => null,
    };

    if (charUuid == null) {
      print("❌ Unsupported command type: $command");
      return false;
    }

    final characteristic = _getCharacteristic(charUuid);
    if (characteristic == null) {
      print("❌ Characteristic not found for UUID: $charUuid");
      return false;
    }

    try {
      final data = utf8.encode(message);
      await characteristic.write(data); // 단일 write 방식 사용

      print("📤 Sent Command ($command): $message");
      return true;
    } catch (e) {
      print("❌ Failed to write characteristic for $command: $e");
      return false;
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
    _streamSubscription?.cancel();
    _streamController.close();
    _services.clear();
    _characteristics.clear();
  }
}
