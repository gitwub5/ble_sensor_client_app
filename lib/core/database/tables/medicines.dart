const String createMedicinesTable = '''
  CREATE TABLE medicines (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    tag_id INTEGER NOT NULL,
    refrigerator_id INTEGER NOT NULL,
    storage_status TEXT CHECK(storage_status IN ('정상', '저온보관', '고온보관', '폐기대상')) NOT NULL,
    quantity INTEGER NOT NULL DEFAULT 0,
    created_at TEXT DEFAULT CURRENT_TIMESTAMP,
    updated_at TEXT DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (tag_id) REFERENCES tags(id) ON DELETE CASCADE,
    FOREIGN KEY (refrigerator_id) REFERENCES refrigerators(id) ON DELETE CASCADE
  )
''';
