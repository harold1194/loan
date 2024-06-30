import 'dart:developer';

import 'package:loan_app/data/database_helper.dart';
import 'package:loan_app/models/customer.dart';

class CustomerProvider {
  final dbHelper = DatabaseHelper();

  Future<void> insertCustomer(Customer customer, int customerId) async {
    customer.clientid = customerId;
    try {
      final db = await dbHelper.database;
      await db.insert('customer', customer.toJson());
    } catch (e) {
      log("Error inserting customer: $e");
    }
  }

  Future<List<Customer>> getCustomerByCustomerId(int customerId) async {
    final db = await dbHelper.database;
    final List<Map<String, dynamic>> maps = await db
        .query('customer', where: 'clientid = ?', whereArgs: [customerId]);
    return List.generate(maps.length, (index) {
      return Customer.fromJson(maps[index]);
    });
  }

  Future<void> updateCustomer(Customer customer) async {
    try {
      final db = await dbHelper.database;
      await db.update('customer', customer.toJson(),
          where: 'id = ?', whereArgs: [customer.id]);
    } catch (e) {
      log("Error deleting customer: $e");
    }
  }

  // delete customer by id
  Future<void> deleteCustomer(int customerId) async {
    try {
      final db = await dbHelper.database;
      await db.delete(
        'customer',
        where: 'id = ?',
        whereArgs: [customerId],
      );
    } catch (e) {
      log("Error deleting supplier: $e");
    }
  }
}
