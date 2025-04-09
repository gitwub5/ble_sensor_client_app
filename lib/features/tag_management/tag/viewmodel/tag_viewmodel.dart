import 'dart:async';
import 'package:bluetooth_app/core/bluetooth/utils/ble_command.dart';
import 'package:bluetooth_app/core/bluetooth/utils/ble_receiver.dart';
import 'package:bluetooth_app/core/database/database.dart';
import 'package:bluetooth_app/features/home/viewmodel/home_viewmodel.dart';
import 'package:bluetooth_app/features/tag_management/tag_data/repository/tag_data_repository.dart';
import 'package:bluetooth_app/shared/enums/command_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart' as fb;
import 'package:bluetooth_app/core/bluetooth/bluetooth_manager.dart';
import 'package:bluetooth_app/features/tag_management/tag/repository/tag_repository.dart';

class TagViewModel extends ChangeNotifier {
  final BluetoothManager _bluetoothManager;
  final TagRepository _tagRepository;
  final TagDataRepository _tagDataRepository;
  final HomeViewModel homeViewModel;

  List<Tag> tags = [];
  List<fb.ScanResult> scanResults = [];
  final Set<String> _connectingDevices = {};
  Set<String> get connectingDevices => _connectingDevices;
  final Map<String, fb.BluetoothDevice> _connectedDevices = {};
  final Map<String, StreamSubscription<Map<String, dynamic>>>
      _dataStreamSubscriptions = {};

  final Map<String, Timer> _inactivityTimers = {};
  final Duration _inactivityTimeout = Duration(seconds: 30);

  bool isScanning = false;
  bool isLoading = false;

  TagViewModel(
    this._bluetoothManager,
    this._tagRepository,
    this._tagDataRepository,
    this.homeViewModel,
  ) {
    _bluetoothManager.stateService.setBluetoothStateListener((state) {
      notifyListeners();
    });
    loadTags();
  }

  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  void _resetInactivityTimer(String remoteId) {
    _inactivityTimers[remoteId]?.cancel();

    _inactivityTimers[remoteId] = Timer(_inactivityTimeout, () {
      print("⏰ $remoteId 비활성 상태, 자동 연결 해제");
      disconnectDevice(remoteId);
    });
  }

  Future<void> loadTags() async {
    homeViewModel.setLoading(true);
    notifyListeners();

    final tagList = await _tagRepository.fetchTags();
    tags = tagList;

    homeViewModel.setLoading(false);
    notifyListeners();
  }

  Future<void> addOrUpdateTag(
      String remoteId, String name, Duration period, DateTime updatedAt) async {
    await _tagRepository.InsertOrUpdateTag(remoteId, name, period, updatedAt);
    await loadTags();
  }

  Future<void> removeTag(int tagId) async {
    await _tagRepository.deleteTag(tagId);
    await loadTags();
  }

  Future<Future<TagDataData?>> getLatestTagData(int tagId) async {
    return _tagDataRepository.getLatestTagDataByTagId(tagId);
  }

  Future<void> startScan(
    Duration duration, {
    List<String> withRemoteIds = const [],
  }) async {
    try {
      isScanning = true;
      scanResults.clear();
      notifyListeners();

      scanResults = await _bluetoothManager.scanService.scanDevices(
        duration,
        withRemoteIds: withRemoteIds,
      );

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
    if (_connectedDevices.containsKey(remoteId)) {
      print("⚠️ Device is already connected: $remoteId");
      if (_dataStreamSubscriptions.containsKey(remoteId)) {
        print("⚠️ Stream already active for $remoteId, skipping.");
        return true;
      }
    }

    if (_connectingDevices.contains(remoteId)) {
      print("⏳ Connection already in progress: $remoteId");
      return false;
    }

    _connectingDevices.add(remoteId);

    try {
      final success = await _bluetoothManager.connectionService
          .connectToDevice(remoteId, autoConnect: autoConnect, mtu: mtu);

      if (!success) {
        print("❌ Device connection failed for $remoteId");
        return false;
      }

      homeViewModel.requestSnackbar(
        message: '$remoteId 연결',
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );

      final device = fb.BluetoothDevice.fromId(remoteId);
      _connectedDevices[remoteId] = device;

      _subscribeToDeviceStream(remoteId);

      // 데이터 요청
      await writeData(
        remoteId,
        commandType: CommandType.update,
        latestTime: DateTime.now(),
      );

      return true;
    } catch (e) {
      print("❌ Connection failed: $e");
      return false;
    } finally {
      _connectingDevices.remove(remoteId);
      notifyListeners();
    }
  }

  Future<void> disconnectDevice(String remoteId) async {
    try {
      await _bluetoothManager.connectionService.disconnectDevice(remoteId);
      _connectedDevices.remove(remoteId);

      _dataStreamSubscriptions[remoteId]?.cancel();
      _dataStreamSubscriptions.remove(remoteId);

      _inactivityTimers[remoteId]?.cancel();
      _inactivityTimers.remove(remoteId);
      notifyListeners();
    } catch (e) {
      print("❌ Disconnection failed: $e");
    }
  }

  bool isDeviceConnected(String remoteId) {
    return _connectedDevices.containsKey(remoteId);
  }

  Future<void> writeData(
    String remoteId, {
    required CommandType commandType,
    required DateTime latestTime,
    Duration? period,
  }) async {
    try {
      final data = BluetoothCommand().toJsonString(latestTime, period);

      await _bluetoothManager.connectionService
          .writeCharacteristic(remoteId, commandType, data);

      _resetInactivityTimer(remoteId);
      print("✅ 데이터 전송 성공 ($remoteId)");
    } catch (e) {
      print("❌ Write failed ($remoteId): $e");
    }
  }

  void _handleReceivedData(String remoteId, dynamic data) async {
    print("📥 TV 데이터 수신 ($remoteId): $data");
    final tag = tags.firstWhere((tag) => tag.remoteId == remoteId);

    final entries = await bleReceiver(tag.id, data);

    if (entries.isNotEmpty) {
      await _tagDataRepository.insertTagDataList(entries);
      print("✅ 데이터 저장 완료 (${entries.length}개 항목)");
    } else {
      print("⚠️ 파싱된 데이터가 없습니다.");
    }

    _resetInactivityTimer(remoteId);
    notifyListeners();
  }

  void _subscribeToDeviceStream(String remoteId) {
    if (_dataStreamSubscriptions.containsKey(remoteId)) {
      print("⚠️ Stream already subscribed for $remoteId");
      return;
    }

    _dataStreamSubscriptions[remoteId] =
        _bluetoothManager.connectionService.stream.listen(
      (data) {
        if (data['remoteId'] == remoteId) {
          _handleReceivedData(remoteId, data['data']);
        }
      },
    );

    print("🔔 Stream Listening Started for $remoteId");
  }

  void dispose() {
    for (var subscription in _dataStreamSubscriptions.values) {
      subscription.cancel();
    }
    for (var timer in _inactivityTimers.values) {
      timer.cancel();
    }
    _inactivityTimers.clear();
    _dataStreamSubscriptions.clear();
    _connectedDevices.clear();
    super.dispose();
  }
}
