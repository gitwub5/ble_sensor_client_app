import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';

// 테이블 스키마 파일 import
import 'tables/tags.dart';
import 'tables/tag_data.dart';
import 'tables/refrigerators.dart';
import 'tables/medicines.dart';
import 'tables/medicine_details.dart';

class AppDatabase {
  static Database? _database;

  /// 📌 싱글턴 인스턴스 반환
  static Future<Database> getInstance() async {
    if (_database != null) return _database!;

    _database = await _initDB();
    return _database!;
  }

  /// 📌 데이터베이스 초기화 및 생성
  static Future<Database> _initDB() async {
    final path = join(await getDatabasesPath(), 'app_database.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await _createTables(db);
      },
    );
  }

  static Future<void> _createTables(Database db) async {
    await db.execute(createTagsTable);
    await db.execute(createTagDataTable);
    await db.execute(createRefrigeratorsTable);
    await db.execute(createMedicinesTable);
    await db.execute(createMedicineDetailsTable);
  }
}
