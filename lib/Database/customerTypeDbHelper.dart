import 'package:presale/Api/Model/ccustomer_type_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class CustomerTypeDBHelper {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'app_database.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE IF NOT EXISTS CustomerType (
            CustomerTypeID INTEGER PRIMARY KEY,
            CustomerTypeName TEXT
          )
        ''');
      },
    );
  }

  // Clear all records
  Future<void> clearCustomerTypes() async {
    final db = await database;
    await db.delete('CustomerType');
  }

  // Insert list of CustomerTypeModel
  Future<void> insertAllCustomerTypes(List<CustomerTypeModel> items) async {
    final db = await database;
    final batch = db.batch();

    for (var item in items) {
      batch.insert(
        'CustomerType',
        item.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    await batch.commit(noResult: true);
  }

  // Optional: Get all records
  Future<List<CustomerTypeModel>> getAllCustomerTypes() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('CustomerType');

    return maps.map((json) => CustomerTypeModel.fromJson(json)).toList();
  }
}
