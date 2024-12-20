// import 'package:expense_app/datepicker.dart';
// import 'package:expense_app/features/auth/view/screen/login_view.dart';
// import 'package:expense_app/features/auth/view_model/bloc/auth_bloc.dart';
import 'package:expense_app/routes/route_name.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

import 'routes/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: BlocProvider(
      //   create: (context) => AuthBloc(),
      //   child: const LoginView(),
      // ),
      initialRoute: RouteName.login,
      onGenerateRoute: Routes.generatedRoute,
    );
  }
}
