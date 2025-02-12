import 'package:drift/drift.dart';
import '../database.dart';
import '../tables/tags.dart';

part 'tag_dao.g.dart';

@DriftAccessor(tables: [Tags])
class TagDao extends DatabaseAccessor<AppDatabase> with _$TagDaoMixin {
  TagDao(AppDatabase db) : super(db);

  Future<int> insertTag(TagsCompanion tag) => into(tags).insert(tag);
  Future<List<Tag>> getAllTags() => select(tags).get();
  Future<Tag?> getTagByRemoteId(String uid) =>
      (select(tags)..where((t) => t.remoteId.equals(uid))).getSingleOrNull();
  Future<bool> updateTag(Tag tag) => update(tags).replace(tag);
  Future<int> deleteTag(int id) =>
      (delete(tags)..where((t) => t.id.equals(id))).go();
}
