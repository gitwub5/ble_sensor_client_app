class TagModel {
  final String tagId;
  final String deviceName;
  final String lastUpdated;
  final String fridgeName;
  bool isSelected; // 체크박스 상태

  TagModel({
    required this.tagId,
    required this.deviceName,
    required this.lastUpdated,
    required this.fridgeName,
    this.isSelected = false,
  });
}
