import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart' as fb;
import 'package:bluetooth_app/core/bluetooth/bluetooth_manager.dart';

// TODO: 블루투스 연결 상태 확인 및 UI 업데이트
class HomeViewModel extends ChangeNotifier {
  final BluetoothManager _bluetoothManager;
  List<fb.ScanResult> scanResults = [];
  fb.BluetoothAdapterState _bluetoothState = fb.BluetoothAdapterState.unknown;

  String? _snackMessage;
  Color _snackBackground = Colors.green;
  Color _snackTextColor = Colors.black;

  String? get snackMessage => _snackMessage;
  Color get snackBackgroundColor => _snackBackground;
  Color get snackTextColor => _snackTextColor;

  bool isLoading = false;

  HomeViewModel(this._bluetoothManager) {
    _bluetoothManager.stateService.setBluetoothStateListener((state) {
      _bluetoothState = state;
      notifyListeners();
    });
  }

  fb.BluetoothAdapterState get bluetoothState => _bluetoothState;

  void setLoading(bool value) {
    isLoading = value;
    notifyListeners(); // ✅ UI 업데이트를 알림
  }

  void requestSnackbar({
    required String message,
    Color backgroundColor = Colors.green,
    Color textColor = Colors.white,
  }) {
    _snackMessage = message;
    _snackBackground = backgroundColor;
    _snackTextColor = textColor;
    notifyListeners();
  }

  void clearSnackbarRequest() {
    _snackMessage = null;
  }
}
