import 'package:drift/drift.dart';
import 'tags.dart';
import 'refrigerators.dart';

class Medicines extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 255)();
  IntColumn get tagId => integer().references(Tags, #id)();
  IntColumn get refrigeratorId => integer().references(Refrigerators, #id)();
  TextColumn get storageStatus => text().withLength(min: 1, max: 50)();
  IntColumn get quantity => integer().withDefault(Constant(0))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().nullable()();
}
