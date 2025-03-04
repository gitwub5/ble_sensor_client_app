const String createTagDataTable = '''
  CREATE TABLE tag_data (
    tag_id INTEGER NOT NULL,
    time TEXT NOT NULL,
    temperature REAL NOT NULL,
    humidity REAL NOT NULL,
    cpu_temperature REAL NOT NULL,
    PRIMARY KEY (tag_id, time),
    FOREIGN KEY (tag_id) REFERENCES tags(id) ON DELETE CASCADE
  )
''';
