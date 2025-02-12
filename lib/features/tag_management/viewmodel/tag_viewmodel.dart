import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart' as fb;
import '../../../shared/models/tag_model.dart';
import 'package:bluetooth_app/core/bluetooth/bluetooth_manager.dart';

class TagViewModel extends ChangeNotifier {
  final BluetoothManager _bluetoothManager;
  List<fb.ScanResult> scanResults = [];
  fb.BluetoothAdapterState _bluetoothState = fb.BluetoothAdapterState.unknown;
  bool isScanning = false;

  TagViewModel(this._bluetoothManager) {
    // ✅ Bluetooth 상태 변화 감지하여 UI 업데이트
    _bluetoothManager.stateService.setBluetoothStateListener((state) {
      _bluetoothState = state;
      notifyListeners(); // ✅ UI 업데이트
    });
  }

  List<TagModel> tags = [
    TagModel(
        remoteId: "1",
        deviceName: "디바이스 0",
        lastUpdated: "00-00-00 16:00",
        fridgeName: "냉장고 A"),
    TagModel(
        remoteId: "2",
        deviceName: "디바이스 1",
        lastUpdated: "00-00-00 18:00",
        fridgeName: "냉장고 B"),
    TagModel(
        remoteId: "3",
        deviceName: "디바이스 2",
        lastUpdated: "00-00-00 19:00",
        fridgeName: "냉장고 C"),
  ];

  void toggleSelection(int index) {
    tags[index].isSelected = !tags[index].isSelected;
    notifyListeners();
  }

  void removeSelectedTags() {
    tags.removeWhere((tag) => tag.isSelected);
    notifyListeners();
  }

  /// ✅ 블루투스 장치 검색 시작 (로딩 상태 추가)
  Future<void> startScan() async {
    try {
      isScanning = true;
      scanResults.clear();
      notifyListeners();

      scanResults = await _bluetoothManager.scanService
          .scanDevices(withServices: ["550e8400-e29b-41d4-a716-446655440010"]);

      isScanning = false;
      notifyListeners();
    } catch (e) {
      isScanning = false;
      notifyListeners();
      print("❌ Bluetooth Scan Failed: $e");
    }
  }
}
