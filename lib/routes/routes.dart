import 'package:expense_app/routes/route_names.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route<dynamic> generatedRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.login:
        return MaterialPageRoute(builder: builder);
    }
  }
}
