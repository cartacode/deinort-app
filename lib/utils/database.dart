import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
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
    String path = join(documentsDirectory.path, "working_app.db");

    ByteData data = await rootBundle.load(join("assets", "app.db"));
    List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    await new File(path).writeAsBytes(bytes);
    return await openDatabase(path, version: 1, onOpen: (db) {
      print("Database opened");
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
    final List<Map<String, dynamic>> maps = await db.rawQuery("SELECT * FROM police WHERE city='$cityName'");

    if (maps.length > 0) {
      return List.generate(maps.length, (i) {
        return Client(
          pid: maps[i]['pid'],
          name: maps[i]['name'],
          city: maps[i]['city'],
        );
      });
    } else {
      return null;
    }
  }

  getPoliceNamesByCity(String cityName) async {
    final db = await database;
    var res = await db.rawQuery("SELECT * FROM police WHERE city='$cityName'");
    List<String> list =
        res.isNotEmpty ? res.toList().map((c) => c['city']) : null;
    return list;
  }
}