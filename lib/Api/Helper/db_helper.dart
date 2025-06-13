import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sql.dart';
import 'package:sqflite/sqlite_api.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();
  factory DBHelper() => _instance;
  DBHelper._internal();

  static Database? _db;

  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await _initDb();
    return _db!;
  }

  Future<Database> _initDb() async {
    final path = join(await getDatabasesPath(), 'followup.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE followup(
          id INTEGER PRIMARY KEY,
          date TEXT,
          mode TEXT,
          followUpBy TEXT,
          status TEXT
        )
      ''');
      },
    );
  }

  Future<void> insertFollowUp(Map<String, dynamic> data) async {
    final dbClient = await db;
    await dbClient.insert(
      'followup',
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<Map<String, dynamic>?> getFollowUp() async {
    final dbClient = await db;
    final result = await dbClient.query('followup', limit: 1);
    return result.isNotEmpty ? result.first : null;
  }

  join(String s, String t) {}
}
