// ignore_for_file: depend_on_referenced_packages

import 'package:sqflite/sqflite.dart';
import "package:path/path.dart";
import 'package:tenis_app/src/data/models/tennis_court.dart';

class MyDataBase {
  static final MyDataBase instance = MyDataBase._init();

  static Database? _database;

  MyDataBase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initBD("tenis.db");
    return _database!;
  }

  Future<Database> _initBD(String filePath) async {
    final dbPath = await getDatabasesPath();
    String path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const doubleType = 'DOUBLE NOT NULL';
    const textType = 'TEXT NOT NULL';

    await db.execute('''
        CREATE TABLE $table (
          ${TennisFields.id} $idType,
          ${TennisFields.precipprob} $doubleType,
          ${TennisFields.name} $textType,
          ${TennisFields.userName} $textType,
          ${TennisFields.dateTime} $textType
        )
   ''');
  }

  Future<TennisCourt> create(TennisCourt tennisCourt) async {
    final db = await instance.database;

    /*final json = tennisCourt.toJson();
    final colums = '${TennisFields.id}, ${TennisFields.number} ';
    final values = '${json[TennisFields.id]}, ${json[TennisFields.number]} ';
    final id = await db.rawInsert('INSERT INTO table_name ($colums) VALUES ($values) ');*/

    final id = await db.insert(table, tennisCourt.toJson());
    return tennisCourt.copy(id: id);
  }

  Future<TennisCourt> read(int id) async {
    final db = await instance.database;

    final maps = await db.query(table,
        columns: TennisFields.values,
        where: '${TennisFields.id}= ?',
        whereArgs: [id]);

    if (maps.isNotEmpty) {
      return TennisCourt.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<TennisCourt>> readList(DateTime dateTime, String name) async {
    final db = await instance.database;

    final maps = await db.query(table,
        columns: TennisFields.values,
        where: '${TennisFields.dateTime}= ? AND ${TennisFields.name}= ?',
        whereArgs: [dateTime.toIso8601String(), name]);

    if (maps.isNotEmpty) {
      final List<TennisCourt> list = [];
      for (var element in maps) {
        list.add(TennisCourt.fromJson(element));
      }
      return list;
    } else {
      //throw Exception('ID $dateTime not found');
      //No hay registros
      return [];
    }
  }

  Future<List<TennisCourt>> readAll() async {
    final db = await instance.database;

    const orderBy = '${TennisFields.dateTime} ASC';
    final result = await db.query(table, orderBy: orderBy);

    //final result = await db.rawQuery('SELECT * FROM $table ORDER BY $orderBy');

    return result.map((json) => TennisCourt.fromJson(json)).toList();
  }

  Future<int> update(TennisCourt tennisCourt) async {
    final db = await instance.database;

    return db.update(
      table,
      tennisCourt.toJson(),
      where: '${TennisFields.id} = ?',
      whereArgs: [tennisCourt.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      table,
      where: '${TennisFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final bd = await instance.database;
    bd.close();
  }
}
