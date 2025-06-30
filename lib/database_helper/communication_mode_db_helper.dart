import 'package:PreSale/Api/Model/communication_mode_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class CommunicationModeDBHelper {
  static final CommunicationModeDBHelper _instance =
      CommunicationModeDBHelper._internal();
  factory CommunicationModeDBHelper() => _instance;
  CommunicationModeDBHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDb();
    return _database!;
  }

  Future<Database> _initDb() async {
    final path = join(await getDatabasesPath(), 'communication_modes.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE communication_modes (
            ModeID INTEGER PRIMARY KEY,
            ModeName TEXT
          )
        ''');
      },
    );
  }

  Future<void> insertMode(CommunicationMode mode) async {
    final db = await database;
    await db.insert(
      'communication_modes',
      mode.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> insertAllModes(List<CommunicationMode> modes) async {
    final db = await database;
    final batch = db.batch();
    for (var mode in modes) {
      batch.insert(
        'communication_modes',
        mode.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit(noResult: true);
  }

  Future<List<CommunicationMode>> getAllModes() async {
    final db = await database;
    final result = await db.query('communication_modes');
    return result.map((e) => CommunicationMode.fromMap(e)).toList();
  }

  Future<void> clearModes() async {
    final db = await database;
    await db.delete('communication_modes');
  }
}
