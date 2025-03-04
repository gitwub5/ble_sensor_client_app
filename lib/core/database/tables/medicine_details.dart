import 'package:drift/drift.dart';
import 'medicines.dart';

class MedicineDetails extends Table {
  IntColumn get id => integer().autoIncrement()(); // PK 추가
  IntColumn get medicineId =>
      integer().unique().references(Medicines, #id)(); // 의약품 ID (FK)
  TextColumn get medicineName => text().withLength(min: 1, max: 255)(); // 의약품명
  TextColumn get medicineType =>
      text().withLength(min: 1, max: 100)(); // 의약품 종류
  TextColumn get manufacturer => text().withLength(min: 1, max: 255)(); // 제약사
  DateTimeColumn get expirationDate => dateTime()(); // 유통기한
  DateTimeColumn get storageDate =>
      dateTime().withDefault(currentDateAndTime)(); // 보관일자
}
