import 'package:presale/Api/Model/competitor_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class CompetitorDBHelper {
  static final CompetitorDBHelper _instance = CompetitorDBHelper._internal();
  factory CompetitorDBHelper() => _instance;
  CompetitorDBHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDb();
    return _database!;
  }

  Future<Database> _initDb() async {
    final path = join(await getDatabasesPath(), 'competitors.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE competitors (
            CompetitorID INTEGER PRIMARY KEY,
            CompetitorName TEXT
          )
        ''');
      },
    );
  }

  Future<void> insertCompetitor(Competitor competitor) async {
    final db = await database;
    await db.insert(
      'competitors',
      competitor.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> insertAllCompetitors(List<Competitor> competitors) async {
    final db = await database;
    final batch = db.batch();
    for (var competitor in competitors) {
      batch.insert(
        'competitors',
        competitor.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit(noResult: true);
  }

  Future<List<Competitor>> getAllCompetitors() async {
    final db = await database;
    final result = await db.query('competitors');
    return result.map((e) => Competitor.fromMap(e)).toList();
  }

  Future<void> clearCompetitors() async {
    final db = await database;
    await db.delete('competitors');
  }
}
