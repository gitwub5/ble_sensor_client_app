class TagModel {
  final String remoteId;
  final String deviceName;
  final String lastUpdated;
  final String fridgeName;
  bool isSelected; // 체크박스 상태

  TagModel({
    required this.remoteId,
    required this.deviceName,
    required this.lastUpdated,
    required this.fridgeName,
    this.isSelected = false,
  });
}
