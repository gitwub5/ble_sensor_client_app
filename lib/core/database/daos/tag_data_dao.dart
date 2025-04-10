import 'package:drift/drift.dart';
import '../database.dart';
import '../tables/tag_data.dart';

part 'tag_data_dao.g.dart';

@DriftAccessor(tables: [TagData])
class TagDataDao extends DatabaseAccessor<AppDatabase> with _$TagDataDaoMixin {
  TagDataDao(AppDatabase db) : super(db);

  /// 📌 특정 TagId로 데이터 조회 (최근 데이터를 기준으로 정렬)
  Future<List<TagDataData>> getTagData(int tagId) {
    return (select(tagData)
          ..where((tbl) => tbl.tagId.equals(tagId))
          ..orderBy([
            (tbl) => OrderingTerm(expression: tbl.time, mode: OrderingMode.desc)
          ]))
        .get();
  }

  /// 📌 특정 TagId로 최근 데이터 기준으로 한 개 조회
  Future<TagDataData?> getLatestTagData(int tagId) {
    return (select(tagData)
          ..where((tbl) => tbl.tagId.equals(tagId))
          ..orderBy([
            (tbl) => OrderingTerm(expression: tbl.time, mode: OrderingMode.desc)
          ])
          ..limit(1))
        .getSingleOrNull();
  }

  /// 📌 특정 TagId로 데이터 삭제
  Future<int> deleteTagData(int tagId) {
    return (delete(tagData)..where((tbl) => tbl.tagId.equals(tagId))).go();
  }

  /// 📌 데이터 추가 (온도와 습도 데이터 삽입) - 여러 개
  Future<bool> insertTagDataList(List<TagDataCompanion> entries) async {
    try {
      await batch((batch) {
        batch.insertAll(tagData, entries);
      });
      return true;
    } catch (e) {
      print("Error inserting data: $e");
      return false;
    }
  }
}
