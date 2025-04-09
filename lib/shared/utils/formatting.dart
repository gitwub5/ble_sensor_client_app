/// shared/utils/tag_utils.dart
String formattedUpdatedAt(DateTime updatedAt) {
  return "${updatedAt.year}-${_twoDigits(updatedAt.month)}-${_twoDigits(updatedAt.day)} "
      "${_twoDigits(updatedAt.hour)}:${_twoDigits(updatedAt.minute)}";
}

String formattedSensorPeriod(int sensorPeriodInSeconds) {
  final duration = Duration(seconds: sensorPeriodInSeconds);

  if (duration.inHours >= 1) {
    return "${duration.inHours}시간";
  } else if (duration.inMinutes >= 1) {
    return "${duration.inMinutes}분";
  }
  return "${duration.inSeconds}초";
}

String _twoDigits(int n) => n.toString().padLeft(2, '0');
