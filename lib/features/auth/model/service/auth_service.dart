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
  static Future<int> insertUser(Database db, User user) async {
    int val = await db.insert(
      'user',
      user.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return val;
  }

  static Future<void> updateUser(Database db, User user) async {
    await db.update(
      'user',
      user.toJson(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  static Future<void> deleteUser(Database db, int id) async {
    await db.delete('user', where: 'id = ?', whereArgs: [id]);
  }

  static Future<String> getUser(Database db, Map<String, String> user) async {
    List<Map> maps = await db.query('user',
        columns: ['username', 'password'],
        where: 'email = ? AND password = ?',
        whereArgs: [user['username'], user['password']]);

    if (maps.length == 1) {
      return "success";
    } else {
      return "fail";
    }
  }
}
