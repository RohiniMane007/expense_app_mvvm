import 'package:expense_app/features/auth/view_model/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController txtUser = TextEditingController();
    TextEditingController txtPass = TextEditingController();
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            TextField(
              controller: txtUser,
              decoration: const InputDecoration(hintText: "Username"),
            ),
            TextField(
              controller: txtPass,
              decoration: const InputDecoration(hintText: "Password"),
            ),
            ElevatedButton(
                onPressed: () {
                  BlocProvider.of<AuthBloc>(context).add(LoginUser(
                      username: txtUser.text.trim(),
                      password: txtPass.text.trim()));
                },
                child: const Text("Login"))
          ],
        ),
      ),
    );
  }
}
