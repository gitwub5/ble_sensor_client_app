import 'package:drift/drift.dart';

class Refrigerators extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 255)();
  TextColumn get location => text().withLength(min: 1, max: 255)();
}
