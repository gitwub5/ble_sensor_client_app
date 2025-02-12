import 'package:flutter_blue_plus/flutter_blue_plus.dart' as fb;
import 'dart:async';
import 'state_service.dart';

class BluetoothScanService {
  final BluetoothStateService _bluetoothStateService;
  final List<fb.ScanResult> _scanResults = [];

  BluetoothScanService(this._bluetoothStateService);

  /// 📌 블루투스 장치 검색 (비동기 스트림 방식)
  Future<List<fb.ScanResult>> scanDevices({
    Duration? timeout,
    List<String> withNames = const [], // 디바이스 이름 필터 추가
    List<String> withServices = const [], // 서비스 UUID 필터 추가 (검색에 사용)
    List<String> withRemoteIds =
        const [], // 디바이스 remoteID 필터 추가 (저장된 장치 검색에 사용)
  }) async {
    if (!await _bluetoothStateService.ensureBluetoothIsOn()) {
      print("❌ Bluetooth is still OFF. Scan aborted.");
      return [];
    }

    final scanTimeout = timeout ?? const Duration(seconds: 5);
    _scanResults.clear();

    // ✅ 스캔 결과 스트림 구독
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

    // ✅ 스캔 완료되면 자동으로 subscription 해제
    fb.FlutterBluePlus.cancelWhenScanComplete(subscription);

    // ✅ 서비스 UUID 리스트 변환 (문자열 -> Guid)
    print("🔍 Scanning for devices with services: $withServices");
    List<fb.Guid> serviceGuids = withServices.map((s) => fb.Guid(s)).toList();
    print("🔍 Service Guids: $serviceGuids");

    // ✅ 스캔 시작 (필터 적용 가능)
    await fb.FlutterBluePlus.startScan(
      withServices: serviceGuids,
      withNames: withNames,
      withRemoteIds: withRemoteIds,
      timeout: scanTimeout,
    );

    // ✅ 스캔 완료될 때까지 대기
    await fb.FlutterBluePlus.isScanning.where((val) => val == false).first;

    return _scanResults;
  }

  void dispose() {
    // ✅ 수동으로 관리할 구독이 없으므로 제거할 필요 없음
  }
}
