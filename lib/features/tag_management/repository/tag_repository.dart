import 'package:drift/drift.dart';
import '../../../core/database/database.dart';
import '../../../core/database/daos/tag_dao.dart';

class TagRepository {
  final TagDao _tagDao;

  TagRepository(AppDatabase database) : _tagDao = TagDao(database);

  Future<List<Tag>> fetchTags() async {
    return await _tagDao.getAllTags();
  }

  Future<void> addTag(String uid, String name) async {
    final newTag = TagsCompanion(
      remoteId: Value(uid),
      name: Value(name),
      sensorPeriod: Value("00:30:00"),
    );
    await _tagDao.insertTag(newTag);
  }

  Future<void> deleteTag(int id) async {
    await _tagDao.deleteTag(id);
  }
}
