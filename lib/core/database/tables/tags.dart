import 'package:drift/drift.dart';
import 'refrigerators.dart';

class Tags extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get uid => text().withLength(min: 1, max: 32).unique()();
  TextColumn get deviceAddress => text().nullable()();
  TextColumn get name => text().withLength(min: 1, max: 255)();
  TextColumn get sensorPeriod => text()();
  DateTimeColumn get lastUpdate => dateTime().nullable()();
  IntColumn get refrigeratorId =>
      integer().references(Refrigerators, #id).nullable()();
}
