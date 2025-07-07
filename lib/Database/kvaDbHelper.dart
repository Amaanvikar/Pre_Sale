import 'package:presale/Api/Model/kva_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class KvaDBHelper {
  static final KvaDBHelper _instance = KvaDBHelper._internal();
  factory KvaDBHelper() => _instance;
  KvaDBHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDb();
    return _database!;
  }

  Future<Database> _initDb() async {
    final path = join(await getDatabasesPath(), 'kva.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE kva_table (
            KVAID INTEGER PRIMARY KEY,
            KVA TEXT
          )
        ''');
      },
    );
  }

  Future<void> insertKVA(KVA kva) async {
    final db = await database;
    await db.insert(
      'kva_table',
      kva.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> insertAllKVA(List<KVA> kvaList) async {
    final db = await database;
    final batch = db.batch();
    for (var kva in kvaList) {
      batch.insert(
        'kva_table',
        kva.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit(noResult: true);
  }

  Future<List<KVA>> getAllKVA() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('kva_table');
    return List.generate(maps.length, (i) => KVA.fromMap(maps[i]));
  }

  Future<void> clearAllKVA() async {
    final db = await database;
    await db.delete('kva_table');
  }
}
