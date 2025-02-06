import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart' as fb;
import '../../../core/bluetooth/blueplus_service.dart';

class HomeViewModel extends ChangeNotifier {
  final BluePlusService _bluePlusService = BluePlusService();
  List<fb.ScanResult> scanResults = [];

  /// 블루투스 상태 모니터링
  void monitorBluetoothState(Function(fb.BluetoothAdapterState) callback) {
    _bluePlusService.monitorBluetoothState(callback);
  }

  /// 블루투스 장치 검색 (TODO: 등록해놓은 디바이스를 검색할 수 있게 수정)
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
