import 'package:sqflite/sqflite.dart';
import '../app_database.dart';
import '../model/search_history.model.dart';

class SearchHistoryService {
  static const String tableName = 'search_history';

  // Insert a new keyword
  Future<int> insert(SearchHistory history) async {
    final db = await AppDatabase.instance;
    return await db.insert(
      tableName,
      history.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Get all search history entries
  Future<List<SearchHistory>> getAll() async {
    final db = await AppDatabase.instance;
    final result = await db.query(tableName, orderBy: 'createdDate DESC');
    return result.map((map) => SearchHistory.fromMap(map)).toList();
  }

  // Delete a specific entry by ID
  Future<int> delete(int id) async {
    final db = await AppDatabase.instance;
    return await db.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Clear all search history
  Future<int> clearAll() async {
    final db = await AppDatabase.instance;
    return await db.delete(tableName);
  }

  // Search by keyword (optional)
  Future<List<SearchHistory>> search(String query) async {
    final db = await AppDatabase.instance;
    final result = await db.query(
      tableName,
      where: 'keyword LIKE ?',
      whereArgs: ['%$query%'],
    );
    return result.map((map) => SearchHistory.fromMap(map)).toList();
  }
}
