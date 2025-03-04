import 'package:drift/drift.dart';

class Refrigerators extends Table {
  IntColumn get id => integer().autoIncrement()(); // 기본 키 (PK)
  TextColumn get name => text().withLength(min: 1, max: 255)(); // 냉장고 이름
  TextColumn get location => text().nullable()(); // 냉장고 위치 (nullable 가능)
}
