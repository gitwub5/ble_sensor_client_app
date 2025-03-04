import 'package:drift/drift.dart';
import 'tags.dart';
import 'refrigerators.dart';

class Medicines extends Table {
  IntColumn get id => integer().autoIncrement()(); // 기본 키 (PK)
  TextColumn get name => text().withLength(min: 1, max: 255)(); // 의약품 이름
  IntColumn get tagId => integer().references(Tags, #id)(); // 등록된 태그 ID (FK)
  IntColumn get refrigeratorId =>
      integer().references(Refrigerators, #id)(); // 냉장고 ID (FK)
  TextColumn get storageStatus => text().nullable()(); // 보관 상태
  IntColumn get quantity =>
      integer().withDefault(const Constant(0))(); // 남은 수량 (기본값 0)
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)(); // 생성 시각
  DateTimeColumn get updatedAt =>
      dateTime().withDefault(currentDateAndTime)(); // 수정 시각
}
