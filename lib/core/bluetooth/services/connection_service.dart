import 'dart:async';
import 'package:bluetooth_app/core/bluetooth/services/state_service.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart' as fb;

class BluetoothConnectionService {
  final BluetoothStateService _bluetoothStateService;
  fb.BluetoothDevice? _connectedDevice;
  StreamSubscription<fb.BluetoothConnectionState>? _connectionSubscription;

  BluetoothConnectionService(this._bluetoothStateService);

  /// 📌 BLE 장치 연결
  Future<void> connectToDevice(fb.BluetoothDevice device,
      {bool autoConnect = false}) async {
    try {
      // ✅ 블루투스 활성화 여부 확인 및 자동 활성화 시도
      if (!await _bluetoothStateService.ensureBluetoothIsOn()) {
        print("❌ Bluetooth is OFF. Cannot connect to device.");
        return;
      }

      // ✅ 이미 연결된 장치인지 확인
      if (_connectedDevice != null &&
          _connectedDevice!.remoteId == device.remoteId) {
        print("⚠️ Device is already connected: ${device.remoteId}");
        return;
      }

      // ✅ 장치 연결 시작
      await device.connect(autoConnect: autoConnect);
      _connectedDevice = device;
      print("✅ Connected to ${device.remoteId}");

      // ✅ 서비스 검색
      await device.discoverServices();

      // ✅ 연결 상태 모니터링 추가 (끊어졌을 때 감지)
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

      await _connectedDevice!.disconnect();
      _connectedDevice = null;

      // ✅ 연결 상태 리스너 해제
      await _connectionSubscription?.cancel();

      print("🔌 Disconnected.");
    }
  }

  /// 📌 장치의 서비스 및 특성 UUID 검색
  Future<void> discoverServices() async {
    if (_connectedDevice == null) return;
    List<fb.BluetoothService> services =
        await _connectedDevice!.discoverServices();

    for (var service in services) {
      print("🔍 Service UUID: ${service.uuid}");
      for (var characteristic in service.characteristics) {
        print("  └ Characteristic UUID: ${characteristic.uuid}");
      }
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

        _connectedDevice = null; // ✅ 연결된 장치 정보 초기화

        // ✅ 자동 재연결 (원하면 추가)
        // await connectToDevice(device);
      }
    });

    // ✅ disconnect 시 자동으로 구독 해제
    device.cancelWhenDisconnected(_connectionSubscription!,
        delayed: true, next: true);
  }

  /// 📌 서비스 해제
  void dispose() {
    _connectionSubscription?.cancel();
  }
}
