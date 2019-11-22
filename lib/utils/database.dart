import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:deinort_app/models/client.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();

  static Database _database;

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "sample.db");
    return await openDatabase(path, version: 1, onOpen: (db) {
    });
  }

  Future<Database> get database async {
    if (_database != null)
    return _database;

    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  getClientsByCity(String cityName) async {
    final db = await database;
    var res = await db.rawQuery("SELECT * FROM Police WHERE city='$cityName'");
    List<Client> list =
        res.isNotEmpty ? res.toList().map((c) => Client.fromMap(c)) : null;
    return list;
  }

  getPoliceNamesByCity(String cityName) async {
    final db = await database;
    var res = await db.rawQuery("SELECT * FROM Police WHERE city='$cityName'");
    List<String> list =
        res.isNotEmpty ? res.toList().map((c) => c['city']) : null;
    return list;
  }
}