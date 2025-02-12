import 'package:drift/drift.dart';
import 'medicines.dart';

class MedicineDetails extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get medicineId => integer().references(Medicines, #id).unique()();
  TextColumn get medicineName => text().withLength(min: 1, max: 255)();
  TextColumn get medicineType => text().nullable()();
  TextColumn get manufacturer => text().nullable()();
  DateTimeColumn get expirationDate => dateTime().nullable()();
  DateTimeColumn get storageDate =>
      dateTime().withDefault(currentDateAndTime)();
}
