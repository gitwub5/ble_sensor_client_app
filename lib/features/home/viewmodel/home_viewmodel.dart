import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart' as fb;
import 'package:bluetooth_app/core/bluetooth/bluetooth_manager.dart';

class HomeViewModel extends ChangeNotifier {
  final BluetoothManager _bluetoothManager;
  List<fb.ScanResult> scanResults = [];
  fb.BluetoothAdapterState _bluetoothState = fb.BluetoothAdapterState.unknown;
  bool isScanning = false;

  HomeViewModel(this._bluetoothManager) {
    // ✅ Bluetooth 상태 변화 감지하여 UI 업데이트
    _bluetoothManager.stateService.setBluetoothStateListener((state) {
      _bluetoothState = state;
      notifyListeners(); // ✅ UI 업데이트
    });
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
}
