import 'package:drift/drift.dart';
import '../database.dart';
import '../tables/tags.dart';

part 'tag_dao.g.dart';

@DriftAccessor(tables: [Tags])
class TagDao extends DatabaseAccessor<AppDatabase> with _$TagDaoMixin {
  TagDao(AppDatabase db) : super(db);

  // 태그 추가
  Future<int> insertTag(TagsCompanion tag) => into(tags).insert(tag);

  // 모든 태그 조회
  Future<List<Tag>> getAllTags() => select(tags).get();

  // 특정 태그 조회 (remoteId 기반)
  Future<Tag?> getTagByRemoteId(String uid) =>
      (select(tags)..where((t) => t.remoteId.equals(uid))).getSingleOrNull();

  // 태그 업데이트
  Future<bool> updateTag(Tag tag) => update(tags).replace(tag);

  // 태그 삭제
  Future<int> deleteTag(int id) =>
      (delete(tags)..where((t) => t.id.equals(id))).go();
}
