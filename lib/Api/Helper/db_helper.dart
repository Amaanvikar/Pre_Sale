import 'package:PreSale/Api/Model/user_model.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();
  factory DBHelper() => _instance;
  DBHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDb();
    return _database!;
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
    final dbClient = await database;
    await dbClient.insert(
      'followup',
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<Map<String, dynamic>?> getFollowUp() async {
    final dbClient = await database;
    final result = await dbClient.query('followup', limit: 1);
    return result.isNotEmpty ? result.first : null;
  }

  join(String s, String t) {}

  Future<int> insertEnquiry(Enquiry enquiry) async {
    final db = await database;
    return await db.insert('enquiries', enquiry.toMap());
  }

  Future<List<Enquiry>> getEnquiries() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('enquiries');
    return List.generate(maps.length, (i) => Enquiry.fromMap(maps[i]));
  }
}
