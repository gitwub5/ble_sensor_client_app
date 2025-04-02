import 'package:bluetooth_app/core/database/database.dart';
import 'package:drift/drift.dart';

class TagRepository {
  final AppDatabase _database;

  TagRepository(this._database);

  Future<List<Tag>> fetchTags() async {
    return await _database.tagDao.getAllTags();
  }

  /// ✅ 태그 추가 (기존 태그가 있으면 업데이트)
  Future<void> addOrUpdateTag(
      String remoteId, String name, Duration period, DateTime updatedAt) async {
    final existingTag = await _database.tagDao.getTagByRemoteId(remoteId);

    final tagCompanion = TagsCompanion(
      remoteId: Value(remoteId),
      name: Value(name),
      sensorPeriod: Value(period.inSeconds), // Duration -> 초 단위 변환
      updatedAt: Value(updatedAt),
    );

    if (existingTag == null) {
      // ❇️ 새 태그 등록
      await _database.tagDao.insertTag(tagCompanion);
    } else {
      // ❇️ 기존 태그 업데이트
      final updatedTag = existingTag.copyWith(
        name: name,
        sensorPeriod: period.inSeconds,
        updatedAt: updatedAt,
      );
      await _database.tagDao.updateTag(updatedTag);
    }
  }

  Future<void> deleteTag(int id) async {
    await _database.tagDao.deleteTag(id);
  }
}
