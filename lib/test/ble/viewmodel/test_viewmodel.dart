import 'package:bluetooth_app/core/bluetooth/utils/ble_command.dart';
import 'package:bluetooth_app/shared/enums/command_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart' as fb;
import 'package:bluetooth_app/core/bluetooth/bluetooth_manager.dart';

class BleTestViewModel extends ChangeNotifier {
  final BluetoothManager _bluetoothManager;
  List<fb.ScanResult> scanResults = [];
  bool isScanning = false;

  BleTestViewModel(this._bluetoothManager) {
    _bluetoothManager.stateService.setBluetoothStateListener((state) {
      notifyListeners();
    });
  }

  /// ✅ BluetoothManager를 외부에서 접근 가능하도록 getter 추가
  BluetoothManager get bluetoothManager => _bluetoothManager;

  /// ✅ 블루투스 장치 검색 시작 (로딩 상태 추가)
  Future<void> startScan() async {
    try {
      isScanning = true;
      scanResults.clear();
      notifyListeners();

      scanResults =
          await _bluetoothManager.scanService.scanDevices(Duration(seconds: 2));

      isScanning = false;
      notifyListeners();
    } catch (e) {
      isScanning = false;
      notifyListeners();
      print("❌ Bluetooth Scan Failed: $e");
    }
  }

  Future<bool> connectToDevice(
    String remoteId, {
    bool autoConnect = false,
    int? mtu,
  }) async {
    try {
      await _bluetoothManager.connectionService.connectToDevice(remoteId,
          autoConnect: autoConnect, mtu: mtu); // ✅ 수정된 connectToDevice 호출
      notifyListeners();
      return true;
    } catch (e) {
      print("❌ Connection failed: $e");
      return false;
    }
  }

  Future<void> disconnectDevice(String remoteId) async {
    // ✅ remoteId를 받도록 수정
    try {
      await _bluetoothManager.connectionService.disconnectDevice(remoteId);
    } catch (e) {
      print("❌ Disconnection failed: $e");
    }
    notifyListeners();
  }

  /// ✅ BLE 장치로 데이터 쓰기
  Future<void> writeData({
    required String remoteId,
    required CommandType commandType,
    required DateTime latestTime,
    Duration? period,
  }) async {
    try {
      final data = BluetoothCommand().toJsonString(latestTime, period);

      final success = await _bluetoothManager.connectionService
          .writeCharacteristic(
              remoteId, commandType, data); // ✅ 수정된 writeCharacteristic 호출

      if (success) {
        print("✅ 데이터 전송 성공");
      } else {
        print("❌ 데이터 전송 실패");
      }
    } catch (e) {
      print("❌ Write failed: $e");
    }
  }
}
