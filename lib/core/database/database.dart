import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

// 테이블 불러오기
import 'tables/tags.dart';
import 'tables/tag_data.dart';
import 'tables/refrigerators.dart';
import 'tables/medicines.dart';
import 'tables/medicine_details.dart';

// DAO 불러오기
import 'daos/tag_dao.dart';
import 'daos/tag_data_dao.dart';

part 'database.g.dart';

@DriftDatabase(
  tables: [Tags, TagData, Refrigerators, Medicines, MedicineDetails],
  daos: [TagDao, TagDataDao],
)
class AppDatabase extends _$AppDatabase {
  // 싱글턴 패턴 적용 (중복 생성 방지)
  static AppDatabase? _instance;

  AppDatabase._internal() : super(_openConnection());

  factory AppDatabase() {
    _instance ??= AppDatabase._internal();
    return _instance!;
  }

  @override
  int get schemaVersion => 1; // 데이터베이스 버전

  // 마이그레이션 지원 (onCreate, onUpgrade)
  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll(); // 처음 실행될 때 모든 테이블 생성
        },
        onUpgrade: (m, from, to) async {
          if (from < to) {
            // ✅ 마이그레이션 로직 추가 가능
          }
        },
      );
}

// `LazyDatabase`로 비동기 DB 생성
LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'app_database.sqlite'));
    return NativeDatabase(file);
  });
}

Future<void> deleteDatabaseFile() async {
  final dbFolder = await getApplicationDocumentsDirectory();
  final filePath = p.join(dbFolder.path, 'app_database.sqlite');
  final file = File(filePath);

  if (await file.exists()) {
    await file.delete();
    print("🗑 데이터베이스 파일이 삭제되었습니다.");
  } else {
    print("❌ 데이터베이스 파일이 존재하지 않습니다.");
  }
}
