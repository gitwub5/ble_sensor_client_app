const String createMedicineDetailsTable = '''
  CREATE TABLE medicine_details (
    medicine_id INTEGER PRIMARY KEY,
    medicine_name TEXT NOT NULL,
    medicine_type TEXT NOT NULL,
    manufacturer TEXT NOT NULL,
    expiration_date TEXT NOT NULL,
    storage_date TEXT DEFAULT (date('now')),
    FOREIGN KEY (medicine_id) REFERENCES medicines(id) ON DELETE CASCADE
  )
''';
