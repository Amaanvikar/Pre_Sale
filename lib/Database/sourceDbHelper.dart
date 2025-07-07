import 'package:presale/Api/Model/source_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SourceDBHelper {
  static final SourceDBHelper _instance = SourceDBHelper._internal();
  factory SourceDBHelper() => _instance;
  SourceDBHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDb();
    return _database!;
  }

  Future<Database> _initDb() async {
    final path = join(await getDatabasesPath(), 'sources.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE sources (
            SourceID INTEGER PRIMARY KEY,
            SourceName TEXT
          )
        ''');
      },
    );
  }

  Future<void> insertSource(Source source) async {
    final db = await database;
    await db.insert(
      'sources',
      source.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> insertAllSources(List<Source> sources) async {
    final db = await database;
    final batch = db.batch();
    for (var s in sources) {
      batch.insert(
        'sources',
        s.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit(noResult: true);
  }

  Future<List<Source>> getAllSources() async {
    final db = await database;
    final result = await db.query('sources');
    return result.map((e) => Source.fromMap(e)).toList();
  }

  Future<void> clearSources() async {
    final db = await database;
    await db.delete('sources');
  }
}
