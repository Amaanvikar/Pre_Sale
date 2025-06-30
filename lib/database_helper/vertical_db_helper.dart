import 'package:PreSale/Api/Model/vertical_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class VerticalDBHelper {
  static final VerticalDBHelper _instance = VerticalDBHelper._internal();
  factory VerticalDBHelper() => _instance;
  VerticalDBHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDb();
    return _database!;
  }

  Future<Database> _initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'verticals.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE verticals (
            VerticalID INTEGER PRIMARY KEY,
            VerticalName TEXT,
            ListAbbreviation TEXT
          )
        ''');
      },
    );
  }

  // Insert Vertical
  Future<void> insertVertical(VerticalModel vertical) async {
    final db = await database;
    await db.insert(
      'verticals',
      vertical.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Insert multiple verticals
  Future<void> insertAllVerticals(List<VerticalModel> verticals) async {
    final db = await database;
    final batch = db.batch();
    for (var vertical in verticals) {
      batch.insert(
        'verticals',
        vertical.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit(noResult: true);
  }

  // Get all verticals
  Future<List<VerticalModel>> getAllVerticals() async {
    final db = await database;
    final result = await db.query('verticals');
    return result.map((e) => VerticalModel.fromMap(e)).toList();
  }

  // Delete all verticals
  Future<void> clearVerticals() async {
    final db = await database;
    await db.delete('verticals');
  }
}
