import 'package:local_database/src/model/cart.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SQFLiteDB {
  static Database? _database;

  static Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('user.db');
    return _database!;
  }

  static Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  static Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';

    try {
      await db.execute('''
              CREATE TABLE $tableCart ( 
              ${CartFields.id} $idType, 
              ${CartFields.size} $textType,
              ${CartFields.quantity} $textType,
              ${CartFields.name} $textType,
              ${CartFields.color} $textType,
              ${CartFields.price} $textType,
              ${CartFields.pid} $textType,
              ${CartFields.createdTime} $textType,
              ${CartFields.image} $textType,
              ${CartFields.currency} $textType
              )
              ''');
    } catch (e) {}
  }

  static Future<bool> create(Cart note) async {
    try {
      await _database?.insert(tableCart, note.toJson());
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<Cart> readOne(String id) async {
    final maps = await _database!.query(
      tableCart,
      columns: CartFields.values,
      where: '${CartFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Cart.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  static Future<List<Cart>> readAllData() async {
    final orderBy = '${CartFields.id} ASC';
    final result = await _database!.query(tableCart, orderBy: orderBy);
    return result.map((json) => Cart.fromJson(json)).toList();
  }

  static Future<int> update(Cart cart) async {
    final db = await _database;
    return db!.update(
      tableCart,
      cart.toJson(),
      where: '${CartFields.id} = ?',
      whereArgs: [cart.id],
    );
  }

  static Future<int> updateQuantity(int id, String value) async {
    return _database!.update(
      tableCart,
      {'${CartFields.quantity}': value},
      where: '$id = ?',
      whereArgs: [id],
    );
  }

  static Future<int> delete(int id) async {
    final db = await _database;

    return await db!.delete(
      tableCart,
      where: '${CartFields.id} = ?',
      whereArgs: [id],
    );
  }

  static Future close() async {
    _database!.close();
  }
}
