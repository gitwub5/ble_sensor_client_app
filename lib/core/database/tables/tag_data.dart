import 'package:drift/drift.dart';
import 'tags.dart';

class TagData extends Table {
  IntColumn get id =>
      integer().autoIncrement()(); // PK 추가 (Drift에서는 자동 증가 ID 추천)
  IntColumn get tagId => integer().references(Tags, #id)(); // 태그 ID (FK)
  DateTimeColumn get time => dateTime()(); // 측정 시각
  RealColumn get temperature => real()(); // 온도
  RealColumn get humidity => real()(); // 습도
  RealColumn get cpuTemperature => real()(); // CPU 온도
}
