import 'package:flutter_blue_plus/flutter_blue_plus.dart' as fb;

// 필요 시 env 파일로 uuid 관리

/// 📌 BLE UUID를 상수로 관리하는 클래스
class BleUUID {
  final String serviceUuidStr = "5f97247b-4474-424c-a826-f8ec299b6937";
  final String rxUuidStr = "5f97247b-4474-424c-a826-f8ec299b6938";
  final String txUuidStr = "5f97247b-4474-424c-a826-f8ec299b6939";

  /// ✅ FlutterBluePlus에서 사용할 UUID 형식 변환
  final fb.Guid serviceUuid;
  final fb.Guid rxUuid;
  final fb.Guid txUuid;

  /// 🔹 생성자에서 초기화
  BleUUID()
      : serviceUuid = fb.Guid("5f97247b-4474-424c-a826-f8ec299b6937"),
        rxUuid = fb.Guid("5f97247b-4474-424c-a826-f8ec299b6938"),
        txUuid = fb.Guid("5f97247b-4474-424c-a826-f8ec299b6939");

  /// 📌 특정 UUID가 유효한지 확인
  bool isValidUuid(String uuid) {
    final uuidRegex = RegExp(
        r'^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$');
    return uuidRegex.hasMatch(uuid);
  }
}

/*
// 사용 예시
import 'utils/ble_uuid.dart';

void main() {
  print("Service UUID: ${BleUUID.serviceUuidString}");
  print("RX UUID: ${BleUUID.rxUuidString}");
  print("TX UUID: ${BleUUID.txUuidString}");

  // ✅ UUID 유효성 검사
  print(BleUUID.isValidUuid("5f97247b-4474-424c-a826-f8ec299b6937")); // true
  print(BleUUID.isValidUuid("invalid-uuid")); // false
}
*/
