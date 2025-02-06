import 'package:bluetooth_app/core/bluetooth/blueplus_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart' as fb;
import '../models/tag_model.dart';

class TagViewModel extends ChangeNotifier {
  final BluePlusService _bluePlusService = BluePlusService();
  List<fb.ScanResult> scanResults = [];

  List<TagModel> tags = [
    TagModel(
        tagId: "1",
        deviceName: "디바이스 0",
        lastUpdated: "00-00-00 16:00",
        fridgeName: "냉장고 A"),
    TagModel(
        tagId: "2",
        deviceName: "디바이스 1",
        lastUpdated: "00-00-00 18:00",
        fridgeName: "냉장고 B"),
    TagModel(
        tagId: "3",
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

  /// 블루투스 장치 검색
  Future<void> startScan() async {
    try {
      scanResults = await _bluePlusService.scanDevices();
      notifyListeners();
    } catch (e) {
      print("❌ Bluetooth Scan Failed: $e");
    }
  }

  /// 블루투스 장치 연결
  Future<void> connectToDevice(fb.BluetoothDevice device) async {
    await _bluePlusService.connectToDevice(device);
    notifyListeners();
  }

  /// 블루투스 장치 연결 해제
  Future<void> disconnectDevice() async {
    await _bluePlusService.disconnectDevice();
    notifyListeners();
  }
}
