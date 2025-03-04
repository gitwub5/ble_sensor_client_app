import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart' as fb;
import 'package:bluetooth_app/core/bluetooth/bluetooth_manager.dart';

class HomeViewModel extends ChangeNotifier {
  final BluetoothManager _bluetoothManager;
  List<fb.ScanResult> scanResults = [];
  fb.BluetoothAdapterState _bluetoothState = fb.BluetoothAdapterState.unknown;
  bool isScanning = false;

  List<String> receivedDataList = [];

  HomeViewModel(this._bluetoothManager) {
    // ✅ Bluetooth 상태 변화 감지하여 UI 업데이트
    _bluetoothManager.stateService.setBluetoothStateListener((state) {
      _bluetoothState = state;
      notifyListeners(); // ✅ UI 업데이트
    });

    // TX 데이터 구독
    _bluetoothManager.connectionService.txStream.listen((data) {
      _handleReceivedData(data);
    });
  }

  /// BLE에서 받은 데이터 처리 (TODO: 응답 중에서 CSV 데이터들만 처리하여 저장하게 구현해야함)
  void _handleReceivedData(String data) {
    receivedDataList.add(data);
    notifyListeners();
    print("📥 BLE 데이터 추가됨: $data");
  }

  /// ✅ 블루투스 현재 상태 가져오기
  fb.BluetoothAdapterState get bluetoothState => _bluetoothState;

  /// ✅ 블루투스 장치 검색 시작 (로딩 상태 추가)
  Future<void> startScan() async {
    try {
      isScanning = true;
      scanResults.clear();
      notifyListeners();

      scanResults = await _bluetoothManager.scanService.scanDevices();

      isScanning = false;
      notifyListeners();
    } catch (e) {
      isScanning = false;
      notifyListeners();
      print("❌ Bluetooth Scan Failed: $e");
    }
  }

  Future<bool> connectToDevice(fb.BluetoothDevice device) async {
    try {
      await _bluetoothManager.connectionService.connectToDevice(device);
      notifyListeners();
      return true;
    } catch (e) {
      print("❌ Connection failed: $e");
      return false;
    }
  }

  Future<void> disconnectDevice() async {
    try {
      await _bluetoothManager.connectionService.disconnectDevice();
      print("🔌 Device disconnected.");
    } catch (e) {
      print("❌ Disconnection failed: $e");
    }
    notifyListeners();
  }
}
