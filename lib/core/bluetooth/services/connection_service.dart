import 'dart:async';
import 'dart:convert';
import 'package:bluetooth_app/core/bluetooth/services/state_service.dart';
import 'package:bluetooth_app/core/bluetooth/utils/ble_uuid.dart';
import 'package:bluetooth_app/shared/enums/command_type.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart' as fb;

class BluetoothConnectionService {
  final BluetoothStateService _bluetoothStateService;
  final BleUUID _bleUUID;
  final Map<String, fb.BluetoothDevice> _connectedDevices = {};
  final Map<String, StreamSubscription<fb.BluetoothConnectionState>>
      _connectionSubscriptions = {};
  final Map<String, StreamSubscription<List<int>>> _streamSubscriptions = {};

  final Map<String, Map<String, fb.BluetoothService>> _services = {};
  final Map<String, Map<String, fb.BluetoothCharacteristic>> _characteristics =
      {};

  // 데이터 스트림 컨트롤러
  final StreamController<Map<String, dynamic>> _streamController =
      StreamController<Map<String, dynamic>>.broadcast();
  Stream<Map<String, dynamic>> get stream => _streamController.stream;

  BluetoothConnectionService(this._bluetoothStateService, this._bleUUID);

  /// 📌 BLE 장치 연결
  Future<bool> connectToDevice(
    String remoteId, {
    required bool autoConnect,
    int? mtu,
  }) async {
    try {
      if (!await _bluetoothStateService.ensureBluetoothIsOn()) {
        print("❌ Bluetooth is OFF. Cannot connect to device.");
        return false;
      }

      var device = fb.BluetoothDevice.fromId(remoteId);

      // 이미 연결된 장치인지 확인
      if (_connectedDevices.containsKey(remoteId)) {
        print("⚠️ Device is already connected: $remoteId");
        return true;
      }

      // 장치 연결 시작
      await device.connect(autoConnect: autoConnect, mtu: mtu);
      await device.connectionState.firstWhere(
          (state) => state == fb.BluetoothConnectionState.connected);

      await device.requestMtu(512);

      _connectedDevices[remoteId] = device;
      print("✅ Connected to $remoteId");

      await _discoverServices(device); // 서비스 검색 및 캐싱
      await _subscribeToNotifyCharacteristic(device); // 온습도 데이터 구독 시작
      _monitorConnectionState(device);
      return true;
    } catch (e) {
      print("❌ Connection failed: $e");
      return false;
    }
  }

  /// 📌 BLE 장치 연결 해제
  Future<void> disconnectDevice(String remoteId) async {
    final device = _connectedDevices[remoteId];
    if (device == null) {
      print("❌ No device connected with ID: $remoteId");
      return;
    }

    print("🔌 Disconnecting from $remoteId...");

    await device.disconnect();
    await device.connectionState.firstWhere(
        (state) => state == fb.BluetoothConnectionState.disconnected);

    _connectedDevices.remove(remoteId);
    _connectionSubscriptions[remoteId]?.cancel();
    _streamSubscriptions[remoteId]?.cancel();

    _connectionSubscriptions.remove(remoteId);
    _streamSubscriptions.remove(remoteId);

    print("🔌 Disconnected from $remoteId.");
  }

  /// 📌 장치의 서비스 및 특성 UUID 검색 및 저장
  Future<void> _discoverServices(fb.BluetoothDevice device) async {
    try {
      List<fb.BluetoothService> services = await device.discoverServices();
      final remoteId = device.remoteId.toString();

      _services[remoteId] = {};
      _characteristics[remoteId] = {};

      for (var service in services) {
        _services[remoteId]![service.uuid.toString()] = service;
        for (var characteristic in service.characteristics) {
          _characteristics[remoteId]![characteristic.uuid.toString()] =
              characteristic;
        }
      }
      print("✅ Services cached for $remoteId");
    } catch (e) {
      print("❌ Service discovery failed: $e");
    }
  }

  /// 📌 특정 캐릭터리스틱 UUID로 가져오기
  fb.BluetoothCharacteristic? _getCharacteristic(String remoteId, String uuid) {
    if (!_characteristics.containsKey(remoteId)) {
      print("❌ No characteristics found for device: $remoteId");
      return null;
    }
    return _characteristics[remoteId]?[uuid];
  }

  /// 📌 Notify Characteristic 구독
  Future<void> _subscribeToNotifyCharacteristic(
      fb.BluetoothDevice device) async {
    final remoteId = device.remoteId.toString();

    if (_streamSubscriptions.containsKey(remoteId)) {
      print("⚠️ Notify already subscribed for $remoteId, skipping...");
      return;
    }
    final characteristic =
        _getCharacteristic(remoteId, _bleUUID.sensorDataCharString);

    if (characteristic == null) {
      print("❌ Characteristic not found for $remoteId");
      return;
    }

    _streamSubscriptions[remoteId] =
        characteristic.onValueReceived.listen((data) {
      try {
        String receivedData = utf8.decode(data);
        final decodedData = jsonDecode(receivedData);

        if (decodedData is Map<String, dynamic>) {
          print("📥 Received Data from $remoteId: $decodedData");
          _streamController.add({
            "remoteId": remoteId,
            "data": decodedData,
          });
        } else {
          print("⚠️ Received non-JSON data: $receivedData");
        }
      } catch (e) {
        print("❌ Error decoding data: $e");
      }
    });

    await characteristic.setNotifyValue(true);
    print("🔔 Subscribed to Notify Characteristic for $remoteId.");
  }

  /// 📌 Write Characteristic (단일 Write)
  Future<bool> writeCharacteristic(
      String remoteId, CommandType command, String message) async {
    final device = _connectedDevices[remoteId];
    if (device == null) {
      print(
          "❌ No device connected with ID: $remoteId. Cannot write characteristic.");
      return false;
    }

    final String? charUuid = switch (command) {
      CommandType.setting => _bleUUID.settingCharString,
      CommandType.update => _bleUUID.sensorDataCharString,
      _ => null,
    };

    if (charUuid == null) {
      print("❌ Unsupported command type: $command");
      return false;
    }

    final characteristic = _getCharacteristic(remoteId, charUuid);
    if (characteristic == null) {
      print("❌ Characteristic not found for UUID: $charUuid on $remoteId");
      return false;
    }

    try {
      final data = utf8.encode(message);
      await characteristic.write(data);
      print("📤 Sent Command ($command) to $remoteId: $message");
      return true;
    } catch (e) {
      print("❌ Failed to write characteristic for $command: $e");
      return false;
    }
  }

  /// 📌 연결 상태 모니터링 (끊어졌을 때 감지)
  void _monitorConnectionState(fb.BluetoothDevice device) {
    final remoteId = device.remoteId.toString();

    _connectionSubscriptions[remoteId]?.cancel(); // 기존 리스너 제거

    _connectionSubscriptions[remoteId] =
        device.connectionState.listen((state) async {
      print("📡 Connection State Changed for $remoteId: $state");

      if (state == fb.BluetoothConnectionState.disconnected) {
        print("⚠️ Device Disconnected: $remoteId");
        _connectedDevices.remove(remoteId);
        _connectionSubscriptions.remove(remoteId);
        _streamSubscriptions.remove(remoteId);
      }
    });
  }

  /// 📌 서비스 해제
  void dispose() async {
    for (var subscription in _connectionSubscriptions.values) {
      await subscription.cancel();
    }
    _connectionSubscriptions.clear();

    for (var subscription in _streamSubscriptions.values) {
      await subscription.cancel();
    }
    _streamSubscriptions.clear();

    await _streamController.close();
    _services.clear();
    _characteristics.clear();
    _connectedDevices.clear();

    print("✅ BluetoothConnectionService resources disposed.");
  }
}
