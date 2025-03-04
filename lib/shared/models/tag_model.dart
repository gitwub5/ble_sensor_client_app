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
}
