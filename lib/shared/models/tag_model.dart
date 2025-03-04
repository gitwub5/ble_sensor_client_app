class TagModel {
  final String name;
  final String remoteId;
  final Duration period;
  final DateTime lastUpdated;
  final String fridgeName;
  bool isSelected; // 체크박스 상태

  TagModel({
    required this.name,
    required this.remoteId,
    required this.lastUpdated,
    required this.period,
    required this.fridgeName,
    this.isSelected = false,
  });
}
