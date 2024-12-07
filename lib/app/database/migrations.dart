class Tables {
  static String tableTitle = "news";

  static String noteTables = '''
    CREATE TABLE IF NOT EXISTS $tableTitle(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT NOT NULL,
      description TEXT,
      content TEXT NOT NULL,
      source TEXT,
      author TEXT,
      urlToImage TEXT,
      url TEXT,
      publishedAt DATETIME DEFAULT CURRENT_TIMESTAMP
    );
   ''';
}