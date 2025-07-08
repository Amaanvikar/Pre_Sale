import 'package:presale/Api/Model/dealer_employe_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DealByDBHelper {
  static final DealByDBHelper _instance = DealByDBHelper._internal();
  factory DealByDBHelper() => _instance;
  DealByDBHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDb();
    return _database!;
  }

  Future<Database> _initDb() async {
    final path = join(await getDatabasesPath(), 'dealer_employee.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE dealer_employees (
            DealerEmployeeID INTEGER PRIMARY KEY,
            EmployeeName TEXT
          )
        ''');
      },
    );
  }

  Future<void> insertDealBy(DealByModel employee) async {
    final db = await database;
    await db.insert(
      'dealer_employees',
      employee.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> insertAllDealBy(List<DealByModel> employees) async {
    final db = await database;
    final batch = db.batch();
    for (var e in employees) {
      batch.insert(
        'dealer_employees',
        e.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit(noResult: true);
  }

  Future<List<DealByModel>> getAllDealBy() async {
    final db = await database;
    final result = await db.query('dealer_employees');
    return result.map((e) => DealByModel.fromMap(e)).toList();
  }

  Future<void> clearDealBy() async {
    final db = await database;
    await db.delete('dealer_employees');
  }
}
