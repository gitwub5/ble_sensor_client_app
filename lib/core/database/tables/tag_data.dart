import 'package:drift/drift.dart';
import 'tags.dart';

class TagData extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get tagId => integer().references(Tags, #id)();
  RealColumn get temperature => real()();
  RealColumn get humidity => real()();
  RealColumn get materialResistivity => real()();
  DateTimeColumn get measuredAt => dateTime().withDefault(currentDateAndTime)();
}
