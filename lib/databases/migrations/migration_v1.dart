import 'package:sqflite/sqflite.dart';

class MigrationV1 {
  static Future<void> create(Database db) async {
    await db.execute('''
      CREATE TABLE search_history (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        keyword TEXT NOT NULL,
        createdDate TEXT NOT NULL
      )
    ''');
  }
}
