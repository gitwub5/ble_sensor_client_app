import 'package:bluetooth_app/shared/enums/command_type.dart';

/// 📌 BLE 명령어 모델
class BluetoothCommand {
  final CommandType commandType; // 명령어 타입
  final DateTime? latestTime; // 최신시간 (nullable)
  final Duration? period; // 주기 (nullable)
  final String? name; // 이름 (nullable)

  /// 📌 생성자
  BluetoothCommand({
    required this.commandType,
    this.latestTime,
    this.period,
    this.name,
  });

  /// 📌 명령어를 BLE로 전송할 문자열 포맷으로 변환
  String toCommandString() {
    final String cmd = _commandTypeToString(commandType);
    final String latestTimeStr = latestTime != null
        ? latestTime!.toIso8601String().split('.')[0]
        : ''; // 소수점 이하 제거
    final String periodStr = period != null
        ? '${period!.inHours.toString().padLeft(2, '0')}:${(period!.inMinutes % 60).toString().padLeft(2, '0')}:${(period!.inSeconds % 60).toString().padLeft(2, '0')}'
        : '';
    final String nameStr = name ?? '';

    return '$cmd|$latestTimeStr|$periodStr|$nameStr.'; // 끝에 '.' 추가
  }

  /// 📌 CommandType을 문자열로 변환
  static String _commandTypeToString(CommandType type) {
    switch (type) {
      case CommandType.setting:
        return 'setting';
      case CommandType.update:
        return 'update';
    }
  }
}

/*
// 1️⃣ BLE에 전송할 명령어 생성 (toCommandString())
final command = BluetoothCommand(
  commandType: CommandType.start,
  latestTime: DateTime.now(),
  period: Duration(minutes: 15),
  name: "MySensor",
);

String bleCommand = command.toCommandString();
print(bleCommand); // "start|2025-02-13T15:30:00|00:15:00|MySensor."
*/
