import 'package:bluetooth_app/core/bluetooth/utils/ble_command.dart';
import 'package:bluetooth_app/shared/enums/command_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart' as fb;
import '../../../shared/models/tag_model.dart';
import 'package:bluetooth_app/core/bluetooth/bluetooth_manager.dart';
import 'package:bluetooth_app/features/tag_management/repository/tag_repository.dart';

class TagViewModel extends ChangeNotifier {
  final BluetoothManager _bluetoothManager;
  final TagRepository _tagRepository;
  List<TagModel> tags = [];

  bool isLoading = false; // Tag 데이터 로딩 상태

  List<fb.ScanResult> scanResults = [];
  bool isScanning = false;

  TagViewModel(this._bluetoothManager, this._tagRepository) {
    // Bluetooth 상태 변화 감지하여 UI 업데이트
    _bluetoothManager.stateService.setBluetoothStateListener((state) {
      notifyListeners(); // UI 업데이트
    });

    // TX 데이터 구독
    _bluetoothManager.connectionService.txStream.listen((data) {
      _handleReceivedData(data);
    });

    loadTags();
  }

  /// BLE에서 받은 데이터 처리 (여기에는 성공 여부말곤 데이터 받을게 없음 저장할 필요 없음)
  void _handleReceivedData(String data) {
    notifyListeners();
    print("📥 BLE 수신됨: $data");
  }

  // DB에서 태그 데이터 불러오기
  Future<void> loadTags() async {
    final tagList = await _tagRepository.fetchTags();
    tags = tagList
        .map((tag) => TagModel(
              id: tag.id,
              remoteId: tag.remoteId,
              name: tag.name,
              updatedAt: tag.updatedAt,
              sensorPeriod: Duration(seconds: tag.sensorPeriod),
              fridgeName: "Unknown", // TODO: 냉장고 정보 조인해서 가져오는 거 추가해야함
            ))
        .toList();
    notifyListeners();
  }

  // 태그 추가
  Future<void> addOrUpdateTag(
      String remoteId, String name, Duration period, DateTime updatedAt) async {
    await _tagRepository.addOrUpdateTag(remoteId, name, period, updatedAt);
    await loadTags(); // UI 갱신
  }

  void toggleSelection(int index) {
    tags[index].isSelected = !tags[index].isSelected;
    notifyListeners();
  }

  /// 선택된 태그 삭제 (DB에서도 삭제)
  Future<void> removeSelectedTags() async {
    final selectedTags = tags.where((tag) => tag.isSelected).toList();

    for (final tag in selectedTags) {
      await _tagRepository.deleteTag(tag.id); // DB에서 삭제
    }

    tags.removeWhere((tag) => tag.isSelected);
    notifyListeners();
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
