/// 📌 BLE 명령어 타입 (start, setting, update)
enum CommandType { start, setting, update }

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
    final String latestTimeStr =
        latestTime != null ? latestTime!.toIso8601String() : '';
    final String periodStr = period != null
        ? '${period!.inHours.toString().padLeft(2, '0')}:${(period!.inMinutes % 60).toString().padLeft(2, '0')}:${(period!.inSeconds % 60).toString().padLeft(2, '0')}'
        : '';
    final String nameStr = name ?? '';

    return '$cmd|$latestTimeStr|$periodStr|$nameStr';
  }

  /// 📌 문자열 명령어를 객체로 변환 (BLE 수신 시 사용)
  factory BluetoothCommand.fromString(String commandString) {
    final parts = commandString.split('|');
    if (parts.length < 1 || parts.length > 4) {
      throw FormatException('Invalid command format: $commandString');
    }

    final commandType = _stringToCommandType(parts[0]);
    final latestTime = (parts.length > 1 && parts[1].isNotEmpty)
        ? DateTime.tryParse(parts[1])
        : null;
    final period = (parts.length > 2 && parts[2].isNotEmpty)
        ? _parseDuration(parts[2])
        : null;
    final name = (parts.length > 3 && parts[3].isNotEmpty) ? parts[3] : null;

    return BluetoothCommand(
      commandType: commandType,
      latestTime: latestTime,
      period: period,
      name: name,
    );
  }

  /// 📌 CommandType을 문자열로 변환
  static String _commandTypeToString(CommandType type) {
    switch (type) {
      case CommandType.start:
        return 'start';
      case CommandType.setting:
        return 'setting';
      case CommandType.update:
        return 'update';
    }
  }

  /// 📌 문자열을 CommandType으로 변환
  static CommandType _stringToCommandType(String type) {
    switch (type.toLowerCase()) {
      case 'start':
        return CommandType.start;
      case 'setting':
        return CommandType.setting;
      case 'update':
        return CommandType.update;
      default:
        throw FormatException('Unknown command type: $type');
    }
  }

  /// 📌 "hh:mm:ss" 형식의 문자열을 Duration으로 변환
  static Duration _parseDuration(String durationStr) {
    final parts = durationStr.split(':').map(int.parse).toList();
    if (parts.length != 3) {
      throw FormatException('Invalid duration format: $durationStr');
    }
    return Duration(hours: parts[0], minutes: parts[1], seconds: parts[2]);
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
print(bleCommand); // "start|2025-02-13T15:30:00|00:15:00|MySensor"
*/

/* 
// 2️⃣ BLE에서 수신한 데이터 변환 (fromString())
String receivedCommand = "update|2025-02-13T16:00:00||";
final parsedCommand = BluetoothCommand.fromString(receivedCommand);

print(parsedCommand.commandType); // CommandType.update
print(parsedCommand.latestTime);  // 2025-02-13T16:00:00
print(parsedCommand.period);      // null
print(parsedCommand.name);        // null
*/
