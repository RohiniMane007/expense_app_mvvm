import 'package:expense_app/features/auth/view/screen/registration_view.dart';
import 'package:expense_app/features/auth/view_model/bloc/auth_bloc.dart';
import 'package:expense_app/features/expense/view/screen/expense_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../comman/alert_dialog.dart';
import '../../../expense/view_model/bloc/expense_bloc.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    TextEditingController txtUser = TextEditingController();
    TextEditingController txtPass = TextEditingController();
    return Material(
      child: SafeArea(
        child: Form(
          key: formKey,
          child: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                  Color(0xFF04776C),
                  Color(0xFF04776C),
                ])),
            child: Column(
              children: [
                const Column(
                  children: [
                    SizedBox(
                      height: 40,
                    ),
                    CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 40,
                        child: Icon(
                          Icons.currency_rupee,
                          size: 40,
                          color: Colors.deepOrange,
                        )),
                    Text(
                      "Login",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: Colors.white),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                  ],
                ),
                Expanded(
                    child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40))),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 40, horizontal: 20.0),
                    child: ListView(
                      children: [
                        TextFormField(
                          controller: txtUser,
                          validator: (value) {
                            return (value == null || value.isEmpty)
                                ? "Enter username"
                                : null;
                          },
                          decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.person),
                              hintText: "Username",
                              border: OutlineInputBorder()),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: txtPass,
                          validator: (value) {
                            return (value == null || value.isEmpty)
                                ? "Enter password"
                                : null;
                          },
                          obscureText: true,
                          obscuringCharacter: '*',
                          decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.lock),
                              suffixIcon: Icon(Icons.remove_red_eye),
                              hintText: "Password",
                              border: OutlineInputBorder()),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        BlocBuilder<AuthBloc, AuthState>(
                          builder: (context, state) {
                            return ElevatedButton(
                              onPressed: () {
                                // Trigger the login event when the button is pressed
                                if (formKey.currentState!.validate()) {
                                  BlocProvider.of<AuthBloc>(context).add(
                                    LoginUser(
                                      username: txtUser.text.trim(),
                                      password: txtPass.text.trim(),
                                    ),
                                  );
                                  if (state.result == "success") {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return BlocProvider(
                                        create: (context) => ExpenseBloc(),
                                        child: const ExpenseView(),
                                      );
                                    }));
                                  } else {
                                    alertDialogBox(
                                      context,
                                      title: 'Alert',
                                      content: const Text(
                                          "Incorrect username or password."),
                                      onOkClicked: () {
                                        // Clear the text fields after showing the alert
                                        txtUser.clear();
                                        txtPass.clear();
                                      },
                                    );
                                  }
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                elevation: 8,
                                minimumSize: const Size.fromHeight(55),
                                backgroundColor: Colors.deepOrange,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text("Log In",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white)),
                            );
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Don't have an account? ",
                              style: TextStyle(
                                  fontSize: 16, color: Colors.black54),
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return BlocProvider(
                                      create: (context) => AuthBloc(),
                                      child: const RegistrationView(),
                                    );
                                  }));
                                },
                                child: const Text(
                                  "Sign Up",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.deepOrange),
                                ))
                          ],
                        )
                      ],
                    ),
                  ),
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
