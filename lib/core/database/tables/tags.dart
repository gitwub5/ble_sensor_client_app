import 'package:drift/drift.dart';
import 'refrigerators.dart';

class Tags extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get remoteId => text().nullable().unique()();
  TextColumn get name => text().withLength(min: 1, max: 255)();
  TextColumn get sensorPeriod => text()();
  DateTimeColumn get lastUpdate => dateTime().nullable()();
  IntColumn get refrigeratorId =>
      integer().references(Refrigerators, #id).nullable()();
}
