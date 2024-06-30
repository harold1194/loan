import 'dart:developer';

import 'package:loan_app/data/database_helper.dart';
import 'package:loan_app/models/clients.dart';
import 'package:sqflite/sqflite.dart';

class ClientProvider {
  final dbHelper = DatabaseHelper();

  Future<int> insertClient(Client client) async {
    int insertRowId = -1;
    try {
      final db = await dbHelper.database;
      if (db.isOpen) {
        insertRowId = await db.insert('clients', client.toJson(),
            conflictAlgorithm: ConflictAlgorithm.replace);
      } else {
        throw Exception("Database is not open.");
      }
    } catch (e) {
      log('Error inserting client: $e');
    }
    return insertRowId;
  }

  Future<List<Client>> getAllClients() async {
    final db = await dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('clients');

    return List.generate(maps.length, (index) {
      return Client.fromJson(maps[index]);
    });
  }

  Future<void> updateClient(Client client) async {
    try {
      final db = await dbHelper.database;

      await db.update('clients', client.toJson(),
          where: 'id = ?', whereArgs: [client.id]);
    } catch (e) {
      log('error on updating $e');
    }
  }

  Future<void> deleteClient(int clientId) async {
    try {
      final db = await dbHelper.database;

      await db.delete('clients', where: 'id = ?', whereArgs: [clientId]);
    } catch (e) {
      log('error deleting client: $e');
    }
  }
}
