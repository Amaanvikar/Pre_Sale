import 'package:PreSale/Api/Model/segment_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SegmentDBHelper {
  static final SegmentDBHelper _instance = SegmentDBHelper._internal();
  factory SegmentDBHelper() => _instance;
  SegmentDBHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDb();
    return _database!;
  }

  Future<Database> _initDb() async {
    final path = join(await getDatabasesPath(), 'segments.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE segments (
            SegmentID INTEGER PRIMARY KEY,
            SegmentName TEXT
          )
        ''');
      },
    );
  }

  Future<void> insertSegment(Segment segment) async {
    final db = await database;
    await db.insert(
      'segments',
      segment.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> insertAllSegments(List<Segment> segments) async {
    final db = await database;
    final batch = db.batch();
    for (var seg in segments) {
      batch.insert(
        'segments',
        seg.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit(noResult: true);
  }

  Future<List<Segment>> getAllSegments() async {
    final db = await database;
    final result = await db.query('segments');
    return result.map((e) => Segment.fromMap(e)).toList();
  }

  Future<void> clearSegments() async {
    final db = await database;
    await db.delete('segments');
  }
}
