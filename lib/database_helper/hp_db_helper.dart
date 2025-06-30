import 'package:PreSale/Api/Model/hp_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class HPDBHelper {
  static final HPDBHelper _instance = HPDBHelper._internal();
  factory HPDBHelper() => _instance;
  HPDBHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDb();
    return _database!;
  }

  Future<Database> _initDb() async {
    final path = join(await getDatabasesPath(), 'hp.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE hp_table (
            HPID INTEGER PRIMARY KEY,
            HP TEXT
          )
        ''');
      },
    );
  }

  Future<void> insertHP(HPModel hpModel) async {
    final db = await database;
    await db.insert(
      'hp_table',
      hpModel.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> insertAllHP(List<HPModel> hpList) async {
    final db = await database;
    final batch = db.batch();
    for (var hp in hpList) {
      batch.insert(
        'hp_table',
        hp.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit(noResult: true);
  }

  Future<List<HPModel>> getAllHP() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('hp_table');
    return List.generate(maps.length, (i) => HPModel.fromMap(maps[i]));
  }

  Future<void> clearAllHP() async {
    final db = await database;
    await db.delete('hp_table');
  }
}
