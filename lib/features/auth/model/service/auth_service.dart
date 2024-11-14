/*import 'package:expense_app/core/utils/error_handler.dart';
import 'package:flutter/material.dart';

import '../../../../core/network/api_client.dart';
import '../../../../core/utils/constant.dart';
import '../models/model.dart';

class AuthService {
  ApiClient client = ApiClient(baseUrl: baseUrl);
  Future<User> getUser() async {
    try {
      final res = await client.get("/user");
      debugPrint(res.toString());
      return User(name: "name", username: "username");
    } catch (e) {
      ErrorHandler.handleError(e);
      throw Exception(ErrorHandler.handleError(e));
    }
  }
}

*/

import 'package:sqflite/sqflite.dart';

import '../models/model.dart';

class AuthService {
  static Future<void> insertUser(Database db, User user) async {
    await db.insert(
      'user',
      user.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<void> updateUser(Database db, User user) async {
    await db.update(
      'user',
      user.toJson(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  static Future<void> deleteUser(Database db, User user) async {
    await db.delete('user', where: 'id = ?', whereArgs: [user.id]);
  }
}
