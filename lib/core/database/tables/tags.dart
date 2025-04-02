import 'package:drift/drift.dart';
import 'refrigerators.dart';

class Tags extends Table {
  IntColumn get id => integer().autoIncrement()(); // 기본 키 (PK)
  TextColumn get remoteId => text().unique()(); // 블루투스 UID
  TextColumn get name => text().withLength(min: 1, max: 10)(); // 태그 이름 (8자 제한)
  IntColumn get sensorPeriod => integer()(); // 감지 주기 (초)
  DateTimeColumn get updatedAt => dateTime()(); // 마지막 통신 시간
  IntColumn get refrigeratorId =>
      integer().nullable().references(Refrigerators, #id)(); // 냉장고 FK
}
