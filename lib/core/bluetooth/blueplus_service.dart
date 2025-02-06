import 'package:flutter_blue_plus/flutter_blue_plus.dart' as fb;
import 'dart:async';

class BluePlusService {
  fb.BluetoothDevice? _connectedDevice;
  StreamSubscription<fb.BluetoothAdapterState>? _adapterStateSubscription;

  /// 블루투스 활성화 여부 확인
  Future<bool> isBluetoothAvailable() async {
    return await fb.FlutterBluePlus.isSupported;
  }

  /// 블루투스 상태 모니터링 (켜짐/꺼짐 감지)
  void monitorBluetoothState(Function(fb.BluetoothAdapterState) callback) {
    _adapterStateSubscription = fb.FlutterBluePlus.adapterState.listen((state) {
      callback(state);
    });
  }

  /// 블루투스 장치 검색
  Future<List<fb.ScanResult>> scanDevices(
      {Duration timeout = const Duration(seconds: 5)}) async {
    if (await fb.FlutterBluePlus.adapterState.first !=
        fb.BluetoothAdapterState.on) {
      throw Exception("Bluetooth is not enabled.");
    }

    // BLE 장치 검색 시작
    await fb.FlutterBluePlus.startScan(timeout: timeout);

    // 검색된 장치 목록 가져오기
    await Future.delayed(timeout);
    return fb.FlutterBluePlus.scanResults.first;
  }

  /// BLE 장치 연결
  Future<void> connectToDevice(fb.BluetoothDevice device,
      {bool autoConnect = false}) async {
    try {
      await device.connect(autoConnect: autoConnect);
      _connectedDevice = device;
      print("✅ Connected to ${device.remoteId}");

      // 서비스 검색
      await device.discoverServices();
    } catch (e) {
      print("❌ Connection failed: $e");
      rethrow;
    }
  }

  /// BLE 장치 연결 해제
  Future<void> disconnectDevice() async {
    if (_connectedDevice != null) {
      await _connectedDevice!.disconnect();
      print("🔌 Disconnected from ${_connectedDevice!.remoteId}");
      _connectedDevice = null;
    }
  }

  /// 장치의 서비스 및 특성 UUID 검색
  Future<void> discoverServices() async {
    if (_connectedDevice == null) return;

    List<fb.BluetoothService> services = await _connectedDevice!
        .discoverServices(); // ✅ fb.BluetoothService로 충돌 방지
    for (var service in services) {
      print("🔍 Service UUID: ${service.uuid}");
      for (var characteristic in service.characteristics) {
        print("  └ Characteristic UUID: ${characteristic.uuid}");
      }
    }
  }

  /// 블루투스 상태 모니터링 해제
  void dispose() {
    _adapterStateSubscription?.cancel();
  }
}
