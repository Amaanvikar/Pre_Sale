import 'package:PreSale/Api/Model/panel_product_moeld.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class PanelProductDBHelper {
  static final PanelProductDBHelper _instance =
      PanelProductDBHelper._internal();
  factory PanelProductDBHelper() => _instance;
  PanelProductDBHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDb();
    return _database!;
  }

  Future<Database> _initDb() async {
    final path = join(await getDatabasesPath(), 'panel_product.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE panel_products (
            PanelProductID INTEGER PRIMARY KEY,
            PanelProductName TEXT
          )
        ''');
      },
    );
  }

  Future<void> insertPanelProduct(PanelProductModel panel) async {
    final db = await database;
    await db.insert(
      'panel_products',
      panel.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> insertAllPanelProducts(List<PanelProductModel> panelList) async {
    final db = await database;
    final batch = db.batch();
    for (var panel in panelList) {
      batch.insert(
        'panel_products',
        panel.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit(noResult: true);
  }

  Future<List<PanelProductModel>> getAllPanelProducts() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('panel_products');
    return List.generate(
      maps.length,
      (i) => PanelProductModel.fromMap(maps[i]),
    );
  }

  Future<void> clearAll() async {
    final db = await database;
    await db.delete('panel_products');
  }
}
