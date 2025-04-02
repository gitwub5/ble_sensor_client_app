import 'dart:convert';

/// 📌 BLE 명령어 모델 (JSON 기반)
class BluetoothCommand {
  /// 📌 JSON 명령어 생성: time은 배열로, period는 선택적 (초 단위)
  String toJsonString(DateTime latestTime, [Duration? period]) {
    final Map<String, dynamic> jsonMap = {
      "time": [
        latestTime.year,
        latestTime.month,
        latestTime.day,
        latestTime.hour,
        latestTime.minute,
        latestTime.second,
      ],
    };

    if (period != null) {
      jsonMap["period"] = period.inSeconds;
    }

    return json.encode(jsonMap);
  }
}
