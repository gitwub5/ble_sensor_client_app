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

part 'database.g.dart';

@DriftDatabase(
  tables: [Tags, TagData, Refrigerators, Medicines, MedicineDetails],
  daos: [TagDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'app_database.sqlite'));
    return NativeDatabase(file);
  });
}
