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
    return await db.query('expenses', orderBy: 'date desc');
  }

  static Future<List<Map<String, dynamic>>> filterItems(
      Database db, int year) async {
    return await db.query(
      'expenses',
      where: 'strftime("%Y", date) = ?', // Filter by year using strftime
      whereArgs: [year.toString()], // Year as parameter
      orderBy: 'date DESC', // Order by date descending
    );
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

  //filter
  static Future<List<Map<String, dynamic>>> getRecordsByWeek(Database db,
      {int? week, int? year}) async {
    // SQL query to get records by week
    return await db.query(
      'expenses',
      where: 'strftime("%Y", date) = ? AND strftime("%W", date) = ?',
      whereArgs: [year.toString(), week.toString()],
      orderBy: 'date DESC',
    );
  }

  // Function to get records by month
  static Future<List<Map<String, dynamic>>> getRecordsByMonth(Database db,
      {int? month, int? year}) async {
    return await db.query(
      'expenses',
      where: 'strftime("%Y", date) = ? AND strftime("%m", date) = ?',
      whereArgs: [
        year.toString(),
        month.toString().padLeft(2, '0')
      ], // Pad month to ensure it has 2 digits
      orderBy: 'date DESC',
    );
  }

  // Function to get records by year
  static Future<List<Map<String, dynamic>>> getRecordsByYear(Database db,
      {int? year}) async {
    return await db.query(
      'expenses',
      where: 'strftime("%Y", date) = ?',
      whereArgs: [year.toString()],
      orderBy: 'date DESC',
    );
  }
}
