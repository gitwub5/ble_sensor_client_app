import 'package:bluetooth_app/core/database/database.dart';
import 'package:drift/drift.dart';

class TagRepository {
  final AppDatabase _database;

  TagRepository(this._database);

  Future<List<Tag>> fetchTags() async {
    return await _database.tagDao.getAllTags();
  }

  Future<void> addTag(
      String remoteId, String name, Duration period, DateTime updatedAt) async {
    final newTag = TagsCompanion(
      remoteId: Value(remoteId),
      name: Value(name),
      sensorPeriod: Value(period.inSeconds), // Duration -> 초 단위 변환
      updatedAt: Value(updatedAt),
    );

    await _database.tagDao.insertTag(newTag);
  }

  Future<void> deleteTag(int id) async {
    await _database.tagDao.deleteTag(id);
  }
}
