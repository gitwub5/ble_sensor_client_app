import 'package:flutter_blue_plus/flutter_blue_plus.dart' as fb;

// 필요 시 env 파일로 uuid 관리
/// 📌 BLE UUID를 상수로 관리하는 클래스
class BleUUID {
  final String serviceString = "5f97247b-4474-424c-a826-f8ec299b6937";
  final String settingCharString = "5f97247b-4474-424c-a826-f8ec299b6938";
  final String sensorDataCharString = "5f97247b-4474-424c-a826-f8ec299b6939";

  /// ✅ FlutterBluePlus에서 사용할 UUID 형식 변환
  final fb.Guid service;
  final fb.Guid setting;
  final fb.Guid sensorData;

  /// 🔹 생성자에서 초기화
  BleUUID()
      : service = fb.Guid("5f97247b-4474-424c-a826-f8ec299b6937"),
        setting = fb.Guid("5f97247b-4474-424c-a826-f8ec299b6938"),
        sensorData = fb.Guid("5f97247b-4474-424c-a826-f8ec299b6939");

  /// 📌 특정 UUID가 유효한지 확인
  bool isValidUuid(String uuid) {
    final uuidRegex = RegExp(
        r'^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$');
    return uuidRegex.hasMatch(uuid);
  }
}
