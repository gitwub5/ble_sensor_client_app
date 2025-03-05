class TagModel {
  final int id;
  final String name;
  final String remoteId;
  final Duration sensorPeriod;
  final DateTime updatedAt;
  final String fridgeName;
  bool isSelected; // 체크박스 상태

  TagModel({
    required this.id,
    required this.name,
    required this.remoteId,
    required this.updatedAt,
    required this.sensorPeriod,
    required this.fridgeName,
    this.isSelected = false,
  });

  /// `updatedAt`을 `yyyy-MM-dd HH:mm` 포맷으로 변환
  String get formattedUpdatedAt {
    return "${updatedAt.year}-${_twoDigits(updatedAt.month)}-${_twoDigits(updatedAt.day)} "
        "${_twoDigits(updatedAt.hour)}:${_twoDigits(updatedAt.minute)}";
  }

  /// `sensorPeriod`를 "30분", "1시간", "2시간" 형식으로 변환
  String get formattedSensorPeriod {
    if (sensorPeriod.inHours >= 1) {
      return "${sensorPeriod.inHours}시간";
    } else if (sensorPeriod.inMinutes >= 1) {
      return "${sensorPeriod.inMinutes}분";
    }
    return "${sensorPeriod.inSeconds}초";
  }

  /// 🔹 두 자리 숫자로 변환하는 헬퍼 메서드 (ex: 9 -> 09)
  String _twoDigits(int n) => n.toString().padLeft(2, '0');
}
