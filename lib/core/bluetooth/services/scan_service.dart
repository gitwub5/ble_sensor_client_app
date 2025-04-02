import 'package:bluetooth_app/core/bluetooth/utils/ble_uuid.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart' as fb;
import 'dart:async';
import 'state_service.dart';

class BluetoothScanService {
  final BluetoothStateService _bluetoothStateService;
  final List<fb.ScanResult> _scanResults = [];
  final BleUUID _bleUUID;

  BluetoothScanService(this._bluetoothStateService, this._bleUUID);

  /// 📌 블루투스 장치 검색 (비동기 스트림 방식)
  Future<List<fb.ScanResult>> scanDevices(Duration duration) async {
    if (!await _bluetoothStateService.ensureBluetoothIsOn()) {
      print("❌ Bluetooth is still OFF. Scan aborted.");
      return [];
    }
    _scanResults.clear();

    // 스캔 결과 스트림 구독
    var subscription = fb.FlutterBluePlus.onScanResults.listen(
      (results) {
        for (var result in results) {
          if (!_scanResults
              .any((r) => r.device.remoteId == result.device.remoteId)) {
            _scanResults.add(result);
            print(
                "🔍 Found Device: ${result.device.remoteId} (${result.advertisementData.advName})");
          }
        }
      },
      onError: (e) => print("❌ Scan Error: $e"),
    );

    // 스캔 완료되면 자동으로 subscription 해제
    fb.FlutterBluePlus.cancelWhenScanComplete(subscription);

    List<fb.Guid> serviceGuids = [_bleUUID.service];

    // 스캔 시작 (필터 적용)
    await fb.FlutterBluePlus.startScan(
      withServices: serviceGuids,
      timeout: duration,
    );

    // 스캔 완료될 때까지 대기
    await fb.FlutterBluePlus.isScanning.where((val) => val == false).first;

    return _scanResults;
  }

  void dispose() {
    // 수동으로 관리할 구독이 없으므로 제거할 필요 없음
  }
}
