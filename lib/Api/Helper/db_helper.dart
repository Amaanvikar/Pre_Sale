import 'package:PreSale/Api/Model/UserRoleModel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

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
    final path = join(await getDatabasesPath(), 'user_roles.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE user_roles(
          UserId INTEGER,
            RoleID INTEGER PRIMARY KEY,
            RoleName TEXT,
            RoleLevelID INTEGER,
            RoleLevelName TEXT,
            VerticalID INTEGER,
            VerticalName TEXT,
            Hierarchy INTEGER,
            IsExcelDownload INTEGER,
            IsPDFDownload INTEGER
        )
      ''');
      },
    );
  }

  Future<void> insertUserRole(UserRole role) async {
    final dbClient = await database;
    await dbClient.insert(
      'user_roles',
      role.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<UserRole>> getAllRoles() async {
    final dbClient = await database;
    final List<Map<String, dynamic>> maps = await dbClient.query('user_roles');

    return List.generate(maps.length, (i) {
      return UserRole.fromMap(maps[i]);
    });
  }

  Future<void> clearAllRoles() async {
    final dbClient = await database;
    await dbClient.delete('user_roles');
  }
}
