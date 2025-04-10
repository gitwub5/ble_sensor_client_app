import 'package:bluetooth_app/core/database/database.dart';

class TagDataRepository {
  final AppDatabase _database;

  TagDataRepository(this._database);

  /// 📌 특정 TagId로 데이터 조회 (최근 데이터를 기준으로 정렬)
  Future<List<TagDataData>> getTagData(int tagId) {
    return _database.tagDataDao.getTagData(tagId);
  }

  /// 📌 특정 TagId로 최근 데이터 기준으로 한 개 조회
  Future<TagDataData?> getLatestTagData(int tagId) {
    return _database.tagDataDao.getLatestTagData(tagId);
  }

  /// 📌 특정 TagId로 데이터 삭제
  Future<int> deleteTagData(int tagId) {
    return _database.tagDataDao.deleteTagData(tagId);
  }

  /// 📌 데이터 추가 (온도와 습도 데이터 삽입) - 여러 개
  Future<bool> insertTagDataList(List<TagDataCompanion> entries) {
    return _database.tagDataDao.insertTagDataList(entries);
  }
}
