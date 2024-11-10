import 'package:expense_app/core/utils/error_handler.dart';
import 'package:flutter/material.dart';

import '../../../core/network/api_client.dart';
import '../../../core/utils/constant.dart';
import 'model.dart';

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
