import 'package:flutter_blue_plus/flutter_blue_plus.dart' as fb;
import 'services/state_service.dart';
import 'services/scan_service.dart';
import 'services/connection_service.dart';
import 'utils/ble_uuid.dart';

class BluetoothManager {
  static BluetoothManager? _instance;
  factory BluetoothManager({BluetoothStateService? stateService}) {
    _instance ??=
        BluetoothManager._internal(stateService ?? BluetoothStateService());
    return _instance!;
  }

  final BluetoothStateService stateService;
  final BluetoothScanService scanService;
  final BluetoothConnectionService connectionService;
  final BleUUID bleUUID = BleUUID();

  BluetoothManager._internal(this.stateService)
      : scanService = BluetoothScanService(stateService),
        connectionService = BluetoothConnectionService(stateService);

  /// ✅ 로그 활성화/비활성화
  void setLoggingEnabled(bool enabled) {
    fb.FlutterBluePlus.setLogLevel(
      enabled ? fb.LogLevel.verbose : fb.LogLevel.none,
    );
  }

  /// ✅ 서비스 해제
  void dispose() {
    stateService.dispose();
    scanService.dispose();
    connectionService.dispose();
  }
}
