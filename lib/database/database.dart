import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import '../utils/constants.dart';

class WeatherDatabase {
  static final WeatherDatabase instance = WeatherDatabase._init();
  static Database? _database;
  WeatherDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB(dbName);
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB, onConfigure: _onConfigure);
  }

  static Future _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $cityTableName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        region TEXT,
        country TEXT,
        lat REAL,
        long REAL
      );
      ''');
  }

  Future<void> close() async {
    final db = await instance.database;
    db.close();
  }
}
