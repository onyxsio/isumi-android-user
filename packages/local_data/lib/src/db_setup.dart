import 'package:local_database/src/cart.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBSetup {
  static Database? _database;

  // static Future<Database> get database async {
  //   if (_database != null) return _database!;

  //   _database = await _initDB('user.db');
  //   return _database!;
  // }
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

    await db.execute('''
CREATE TABLE $tableCart ( 
  ${CartFields.id} $idType, 
  ${CartFields.size} $textType,
  ${CartFields.quantity} $textType,
  ${CartFields.name} $textType,
  ${CartFields.color} $textType,
  ${CartFields.price} $textType
  )
''');
  }

  static Future<int> create(Cart note) async {
    final db = await _database;
    // final json = note.toJson();
    // final columns =
    //     '${NoteFields.title}, ${NoteFields.description}, ${NoteFields.time}';
    // final values =
    //     '${json[NoteFields.title]}, ${json[NoteFields.description]}, ${json[NoteFields.time]}';
    // final id = await db
    //     .rawInsert('INSERT INTO table_name ($columns) VALUES ($values)');

    try {
      await db?.insert(tableCart, note.toJson());
      return 1;
    } catch (e) {
      return 0;
    }
  }

  Future<Cart> readNote(String id) async {
    final db = await _database;
    final maps = await db!.query(
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

  Future<List<Cart>> readAllNotes() async {
    final db = await _database;

    final orderBy = '${CartFields.id} ASC';
    // final result =
    //     await db.rawQuery('SELECT * FROM $tableNotes ORDER BY $orderBy');

    final result = await db!.query(tableCart, orderBy: orderBy);

    return result.map((json) => Cart.fromJson(json)).toList();
  }

  Future<int> update(Cart note) async {
    final db = await _database;

    return db!.update(
      tableCart,
      note.toJson(),
      where: '${CartFields.id} = ?',
      whereArgs: [note.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await _database;

    return await db!.delete(
      tableCart,
      where: '${CartFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await _database;

    db!.close();
  }
}
