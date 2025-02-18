import 'package:flutter_blue_plus/flutter_blue_plus.dart' as fb;
import 'dart:async';

class BluetoothStateService {
  StreamSubscription<fb.BluetoothAdapterState>? _adapterStateSubscription;
  Function(fb.BluetoothAdapterState)? _onBluetoothStateChanged;

  BluetoothStateService() {
    _monitorBluetoothState();
  }

  /// 📌 블루투스 상태 모니터링 (켜짐/꺼짐 감지)
  void _monitorBluetoothState() {
    _adapterStateSubscription?.cancel();
    _adapterStateSubscription = fb.FlutterBluePlus.adapterState.listen((state) {
      print("📡 Bluetooth State Changed: $state");
      _onBluetoothStateChanged?.call(state); // 등록된 콜백 실행
    });
  }

  /// 📌 블루투스 상태 변화 감지를 위한 콜백 등록 (ViewModel에서 사용)
  void setBluetoothStateListener(Function(fb.BluetoothAdapterState) callback) {
    _onBluetoothStateChanged = callback;
  }

  /// 📌 블루투스가 현재 켜져 있는지 확인
  Future<bool> isBluetoothEnabled() async {
    final adapterState = await fb.FlutterBluePlus.adapterState.first;
    return adapterState == fb.BluetoothAdapterState.on;
  }

  /// 📌 블루투스가 꺼져 있으면 자동으로 켜기 (Android만)
  Future<bool> ensureBluetoothIsOn() async {
    if (await isBluetoothEnabled()) return true;
    print("❌ Bluetooth is OFF. Attempting to turn it on...");
    await fb.FlutterBluePlus.turnOn();
    return await isBluetoothEnabled();
  }

  /// 📌 서비스 해제 (앱 종료 시 모든 스트림 해제)
  void dispose() {
    _adapterStateSubscription?.cancel();
  }
}
