import 'package:sqflite/sqflite.dart';
import '../models/expense_model.dart';

class ExpenseService {
  static Future<void> insertItem(Database db, Expense item) async {
    await db.insert(
      'expenses',
      item.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getItems(Database db) async {
    return await db.query('expenses');
  }

  static Future<void> updateItem(Database db, Expense item) async {
    await db.update(
      'expenses',
      item.toJson(),
      where: 'id = ?',
      whereArgs: [item.id],
    );
  }

  static Future<void> deleteItem(Database db, int id) async {
    await db.delete(
      'expenses',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
