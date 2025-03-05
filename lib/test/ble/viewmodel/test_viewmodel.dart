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

    _bluetoothManager.connectionService.txStream.listen((data) {
      _handleReceivedData(data);
    });
  }

  /// ✅ BluetoothManager를 외부에서 접근 가능하도록 getter 추가
  BluetoothManager get bluetoothManager => _bluetoothManager;

  void _handleReceivedData(String data) {
    print("📥 BLE 데이터 수신: $data");
  }

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

  /// ✅ BLE 장치로 데이터 쓰기
  Future<void> writeData(CommandType commandType,
      {DateTime? latestTime, Duration? period, String? name}) async {
    try {
      final command = BluetoothCommand(
        commandType: commandType,
        latestTime: latestTime,
        period: period,
        name: name,
      );

      String data = command.toJsonString();

      await _bluetoothManager.connectionService.writeCharacteristic(data);

      print("📤 Sent Data: $data");
    } catch (e) {
      print("❌ Write failed: $e");
    }
  }
}
