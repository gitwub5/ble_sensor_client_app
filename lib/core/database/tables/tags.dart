const String createTagsTable = '''
  CREATE TABLE tags (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    remoteId TEXT UNIQUE NOT NULL,
    name TEXT NOT NULL,
    sensor_period INTEGER NOT NULL,
    updated_at TEXT NOT NULL,
    refrigerator_id INTEGER,
    FOREIGN KEY (refrigerator_id) REFERENCES refrigerators(id) ON DELETE SET NULL
  )
''';
