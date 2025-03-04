import 'package:sqflite/sqflite.dart';

class TagRepository {
  final Database _db;

  TagRepository(this._db);

  /// ✅ 태그 추가 (뷰모델에서 데이터 넣을 때 DTO 형식으로 받게 할 수도 있음)
  Future<int> addTag(
      String remoteId, String name, Duration period, DateTime updatedAt) async {
    return await _db.insert('tags', {
      'remoteId': remoteId,
      'name': name,
      'sensor_period':
          period.inSeconds, // 초 단위 저장 (TODO: 00:00:00 형태로 수정하거나 해야함)
      'updated_at': updatedAt.toIso8601String(),
    });
  }

  /// ✅ 모든 태그 가져오기 (모델 변환 포함)
  Future<List<Map<String, dynamic>>> fetchTags() async {
    return await _db.query('tags');
  }

  Future<int> deleteTag(int id) async {
    return await _db.delete('tags', where: 'id = ?', whereArgs: [id]);
  }
}
