import 'dart:convert';
import 'package:bluetooth_app/shared/enums/command_type.dart';

/// 📌 BLE 명령어 모델 (JSON 기반)
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

  /// 📌 명령어를 JSON 형식으로 변환
  String toJsonString() {
    final Map<String, dynamic> jsonMap = {
      "command": _commandTypeToString(commandType),
      "latest_time": latestTime?.toIso8601String().split('.')[0], // 밀리초 제거
      "period": period != null
          ? '${period!.inHours.toString().padLeft(2, '0')}:${(period!.inMinutes % 60).toString().padLeft(2, '0')}:${(period!.inSeconds % 60).toString().padLeft(2, '0')}'
          : null,
      "name": name,
    };

    return json.encode(jsonMap); // JSON 문자열 변환
  }

  /// 📌 JSON 문자열을 `BluetoothCommand` 객체로 변환 (BLE 수신 시 사용)
  factory BluetoothCommand.fromJsonString(String jsonString) {
    final Map<String, dynamic> jsonMap = json.decode(jsonString);

    return BluetoothCommand(
      commandType: _stringToCommandType(jsonMap["command"]),
      latestTime: jsonMap["latest_time"] != null
          ? DateTime.tryParse(jsonMap["latest_time"])
          : null,
      period:
          jsonMap["period"] != null ? _parseDuration(jsonMap["period"]) : null,
      name: jsonMap["name"],
    );
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

  /// 📌 문자열을 CommandType으로 변환
  static CommandType _stringToCommandType(String type) {
    switch (type.toLowerCase()) {
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
print(bleCommand); // "start|2025-02-13T15:30:00|00:15:00|MySensor."
*/
