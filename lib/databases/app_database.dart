import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'migrations/migration_v1.dart';

class AppDatabase {
  static Database? _db;

  static Future<Database> get instance async {
    if (_db != null) return _db!;
    _db = await _init();
    return _db!;
  }

  static Future<Database> _init() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'medicinal_plants.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await MigrationV1.create(db);
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        //
      },
    );
  }
}
