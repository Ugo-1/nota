import 'package:nota/core/model/nota_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class NotaDatabase{
  static final NotaDatabase instance = NotaDatabase._init();
  static Database? _database;

  NotaDatabase._init();

  Future<Database> get dataBase async {
    if (_database != null) return _database!;

    _database = await _initDb('nota.db');
    return _database!;
  }

  Future<Database> _initDb(String filepath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filepath);

    return await openDatabase(path, version: 1, onCreate: _createDb);
  }

  Future _createDb(Database db, int version) async {
    const String idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const String boolType = 'BOOLEAN NOT NULL';
    const String textType = 'TEXT NOT NULL';
    const String intType = 'INTEGER';

    await db.execute(
    'CREATE TABLE $tableName (${NoteFields.id} $idType, ${NoteFields.colorIndex} $intType, ${NoteFields.isFavorite} $boolType, ${NoteFields.title} $textType, ${NoteFields.description} $textType, ${NoteFields.createdTime} $textType)');
  }

  Future<Nota> create (Nota nota) async {
    final db = await instance.dataBase;
    final id = await db.insert(tableName, nota.toJson());

    return nota.copy(id: id);
  }

  Future<List<Nota>> readAll() async {
    final db = await instance.dataBase;
    final maps = await db.query(tableName);

    if (maps.isNotEmpty){
      return maps.map((dataRow) => Nota.fromJson(dataRow)).toList();
    } else {
      return [];
    }
  }

  Future<int> update(Nota nota) async {
    final db = await instance.dataBase;
    return await db.update(
      tableName,
      nota.toJson(),
      where: '${NoteFields.id} = ?',
      whereArgs: [nota.id],
    );
  }

  Future<int> delete(Nota nota) async {
    final db = await instance.dataBase;
    return await db.delete(
      tableName,
      where: '${NoteFields.id} = ?',
      whereArgs: [nota.id],
    );
  }

  // Future close() async {
  //   final db = await instance.dataBase;
  //
  //   db.close();
  // }
}