import 'package:expense_app/features/auth/view/view.dart';
import 'package:expense_app/features/auth/view_model/bloc/auth_bloc.dart';
import 'package:expense_app/routes/route_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RouteData {
  static getRouteData(
      BuildContext context, String screenName, Map<String, dynamic> args) {
    switch (screenName) {
      case RouteName.login:
        return BlocProvider(
          create: (context) => AuthBloc(),
          child: const LoginView(),
        );
    }
  }
}
