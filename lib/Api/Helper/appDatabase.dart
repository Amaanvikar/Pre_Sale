import 'package:presale/Api/Model/communication_mode_model.dart';
import 'package:presale/Api/Model/ownershipTypeModel.dart';
import 'package:presale/Api/Model/subSegmentModel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'package:presale/Api/Model/vertical_model.dart';
import 'package:presale/Api/Model/source_model.dart';
import 'package:presale/Api/Model/segment_model.dart';
import 'package:presale/Api/Model/panel_product_moeld.dart';
import 'package:presale/Api/Model/kva_model.dart';
import 'package:presale/Api/Model/hp_model.dart';
import 'package:presale/Api/Model/dealer_employe_model.dart';
import 'package:presale/Api/Model/ccustomer_type_model.dart';
import 'package:presale/Api/Model/competitor_model.dart';

class AppDatabase {
  static final AppDatabase _instance = AppDatabase._internal();
  factory AppDatabase() => _instance;
  AppDatabase._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDb();
    return _database!;
  }

  Future<Database> _initDb() async {
    final path = join(await getDatabasesPath(), 'presale.db');
    return await openDatabase(path, version: 1, onCreate: _createTables);
  }

  Future<void> _createTables(Database db, int version) async {
    await db.execute('''
      CREATE TABLE verticals (
        VerticalID INTEGER PRIMARY KEY,
        VerticalName TEXT,
        ListAbbreviation TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE sources (
        SourceID INTEGER PRIMARY KEY,
        SourceName TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE segments (
        SegmentID INTEGER PRIMARY KEY,
        SegmentName TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE sub_segments (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
        SegmentID INTEGER,
        SegmentName TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE panel_products (
        PanelProductID INTEGER PRIMARY KEY,
        PanelProductName TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE kva_table (
        KVAID INTEGER PRIMARY KEY,
        KVA TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE hp_table (
        HPID INTEGER PRIMARY KEY,
        HP TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE dealer_employees (
        DealerEmployeeID INTEGER PRIMARY KEY,
        EmployeeName TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE CustomerType (
        CustomerTypeID INTEGER PRIMARY KEY,
        CustomerTypeName TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE competitors (
        CompetitorID INTEGER PRIMARY KEY,
        CompetitorName TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS communication_modes (
        ModeID INTEGER PRIMARY KEY,
        ModeName TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE dg_ownerships (
        DGOwnerShipID INTEGER PRIMARY KEY,
        DGOwnerShipName TEXT
      )
    ''');

    await db.execute('''
    CREATE TABLE competitor (
      CompetitorID INTEGER PRIMARY KEY,
      CompetitorName TEXT
    )
  ''');
  }

  // ---------- Vertical ----------
  Future<void> insertVertical(VerticalModel vertical) async {
    final db = await database;
    await db.insert(
      'verticals',
      vertical.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> insertAllVerticals(List<VerticalModel> verticals) async {
    final db = await database;
    final batch = db.batch();
    for (var v in verticals) {
      batch.insert(
        'verticals',
        v.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit(noResult: true);
  }

  Future<List<VerticalModel>> getAllVerticals() async {
    final db = await database;
    final result = await db.query('verticals');
    return result.map((e) => VerticalModel.fromMap(e)).toList();
  }

  Future<void> clearVerticals() async {
    final db = await database;
    await db.delete('verticals');
  }

  // ---------- Source ----------
  Future<void> insertSource(SourceModel source) async {
    final db = await database;
    await db.insert(
      'sources',
      source.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> insertAllSources(List<SourceModel> sources) async {
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

  Future<List<SourceModel>> getAllSources() async {
    final db = await database;
    final result = await db.query('sources');
    return result.map((e) => SourceModel.fromMap(e)).toList();
  }

  Future<void> clearSources() async {
    final db = await database;
    await db.delete('sources');
  }

  // ---------- Segment ----------
  Future<void> insertSegment(SegmentModel segment) async {
    final db = await database;
    await db.insert(
      'segments',
      segment.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> insertAllSegments(List<SegmentModel> segments) async {
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

  Future<List<SegmentModel>> getAllSegments() async {
    final db = await database;
    final result = await db.query('segments');
    return result.map((e) => SegmentModel.fromMap(e)).toList();
  }

  Future<void> clearSegments() async {
    final db = await database;
    await db.delete('segments');
  }

  Future<void> syncSubSegments(
    List<Map<String, dynamic>> subSegmentData,
  ) async {
    final db = await database;
    await db.delete('sub_segments');

    for (var item in subSegmentData) {
      await db.insert('sub_segments', {
        'segment_id': item['SegmentID'],
        'sub_segment_name': item['SubSegmentName'],
      });
    }

    print("${subSegmentData.length} subsegments saved to local DB");
  }

  Future<List<subSegmentModel>> getSubSegmentsBySegmentId(int segmentId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'sub_segments',
      where: 'segment_id = ?',
      whereArgs: [segmentId],
    );

    return maps.map((map) => subSegmentModel.fromMap(map)).toList();
  }

  // ---------- Panel Product ----------
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
    final result = await db.query('panel_products');
    return result.map((e) => PanelProductModel.fromMap(e)).toList();
  }

  Future<void> clearPanelProducts() async {
    final db = await database;
    await db.delete('panel_products');
  }

  // ---------- KVA ----------
  Future<void> insertKVA(KVAModel kva) async {
    final db = await database;
    await db.insert(
      'kva_table',
      kva.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> insertAllKVA(List<KVAModel> kvaList) async {
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

  Future<List<KVAModel>> getAllKVA() async {
    final db = await database;
    final result = await db.query('kva_table');
    return result.map((e) => KVAModel.fromMap(e)).toList();
  }

  Future<void> clearKVA() async {
    final db = await database;
    await db.delete('kva_table');
  }

  // ---------- HP ----------
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
    final result = await db.query('hp_table');
    return result.map((e) => HPModel.fromMap(e)).toList();
  }

  Future<void> clearHP() async {
    final db = await database;
    await db.delete('hp_table');
  }

  // ---------- Dealer Employee ----------
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
    for (var emp in employees) {
      batch.insert(
        'dealer_employees',
        emp.toMap(),
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

  // ---------- Customer Type ----------
  Future<void> insertAllCustomerTypes(List<CustomerTypeModel> types) async {
    final db = await database;
    final batch = db.batch();
    for (var item in types) {
      batch.insert(
        'CustomerType',
        item.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit(noResult: true);
  }

  Future<List<CustomerTypeModel>> getAllCustomerTypes() async {
    final db = await database;
    final result = await db.query('CustomerType');
    return result.map((e) => CustomerTypeModel.fromJson(e)).toList();
  }

  Future<void> clearCustomerTypes() async {
    final db = await database;
    await db.delete('CustomerType');
  }

  // ---------- Competitors ----------
  Future<void> insertAllCompetitors(List<competitorModel> competitors) async {
    final db = await database;
    final batch = db.batch();
    for (var c in competitors) {
      batch.insert(
        'competitors',
        c.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit(noResult: true);
  }

  Future<List<competitorModel>> getAllCompetitors() async {
    final db = await database;
    final result = await db.query('competitors');
    return result.map((e) => competitorModel.fromMap(e)).toList();
  }

  Future<void> clearCompetitors() async {
    final db = await database;
    await db.delete('competitors');
  }

  // ---------- Communicatoion Mode ----------
  Future<void> insertAllCommunicationModes(
    List<CommunicationModeModel> items,
  ) async {
    final db = await database;
    final batch = db.batch();

    for (var item in items) {
      batch.insert(
        'communication_modes',
        item.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    await batch.commit(noResult: true);
  }

  // Get all communication modes
  Future<List<CommunicationModeModel>> getAllCommunicationModes() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'communication_modes',
    );
    return maps.map((json) => CommunicationModeModel.fromMap(json)).toList();
  }

  // Clear communication modes
  Future<void> clearCommunicationModes() async {
    final db = await database;
    await db.delete('communication_modes');
  }

  // ---------- DG Ownership ----------
  Future<void> insertAllDGOwnerships(List<DGOwnershipModel> ownerships) async {
    final db = await database;
    final batch = db.batch();
    for (var item in ownerships) {
      batch.insert(
        'dg_ownerships',
        item.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit(noResult: true);
  }

  Future<List<DGOwnershipModel>> getAllDGOwnerships() async {
    final db = await database;
    final result = await db.query('dg_ownerships');
    return result.map((e) => DGOwnershipModel.fromMap(e)).toList();
  }

  Future<void> clearDGOwnerships() async {
    final db = await database;
    await db.delete('dg_ownerships');
  }
}
