import 'package:expense_app/routes/route_name.dart';
import 'package:flutter/material.dart';
import 'route_data.dart';

class Routes {
  static Route<dynamic> generatedRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.login:
        return MaterialPageRoute(
            builder: (BuildContext context) =>
                RouteData.getRouteData(context, RouteName.login, {}));

      case RouteName.register:
        return MaterialPageRoute(
            builder: (BuildContext context) =>
                RouteData.getRouteData(context, RouteName.register, {}));

      case RouteName.addUpdateExpense:
        return MaterialPageRoute(
            builder: (BuildContext context) => RouteData.getRouteData(
                context, RouteName.addUpdateExpense, {}));

      case RouteName.expenseList:
        return MaterialPageRoute(
            builder: (BuildContext context) =>
                RouteData.getRouteData(context, RouteName.expenseList, {}));

      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Center(
              child: Text('No route defined'),
            ),
          );
        });
    }
  }
}
