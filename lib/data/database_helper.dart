import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    try {
      String path = join(await getDatabasesPath(), 'crud.db');
      return await openDatabase(path, version: 1,
          onCreate: (Database db, int version) async {
        if (kDebugMode) {
          print('Database created with version: $version');
        }
        await db.execute('''CREATE TABLE IF NOT EXISTS clients (
	        id INTEGER PRIMARY KEY,
	        fname TEXT,
	        mname TEXT,
	        lname TEXT
        )''');

        await db.execute('''CREATE TABLE IF NOT EXISTS customer(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          cname TEXT,
          goods TEXT,
          contactno TEXT,
          contactname TEXT,
          clientid INTEGER,
          FOREIGN KEY (clientid) REFERENCES client (id) ON DELETE CASCADE
        )''');
      });
    } catch (e) {
      if (kDebugMode) {
        print('Error initializing database: $e');
      }
      rethrow;
    }
  }
}
