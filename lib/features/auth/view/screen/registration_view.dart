import 'package:expense_app/features/auth/view_model/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}

class RegistrationView extends StatelessWidget {
  const RegistrationView({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    TextEditingController txtName = TextEditingController();
    TextEditingController txtEmail = TextEditingController();
    TextEditingController txtPhone = TextEditingController();
    TextEditingController txtPassword = TextEditingController();
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: formKey,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                controller: txtName,
                validator: (value) {
                  return (value != null && value.isEmpty) ? 'Enter Name' : null;
                },
                decoration: const InputDecoration(
                    hintText: "Full Name *", border: OutlineInputBorder()),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                controller: txtEmail,
                validator: (value) {
                  return (value != null && value.isEmpty)
                      ? 'Enter valid email'
                      : null;
                },
                decoration: const InputDecoration(
                    hintText: "Email *", border: OutlineInputBorder()),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                keyboardType: TextInputType.phone,
                controller: txtPhone,
                validator: (value) {
                  return (value != null && value.isEmpty)
                      ? 'Enter Mobile'
                      : null;
                },
                decoration: const InputDecoration(
                    hintText: "Mobile No *", border: OutlineInputBorder()),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                obscureText: true,
                obscuringCharacter: '*',
                controller: txtPassword,
                validator: (value) {
                  return (value != null && value.isEmpty)
                      ? 'Enter Password'
                      : null;
                },
                decoration: const InputDecoration(
                    hintText: "Password *", border: OutlineInputBorder()),
              ),
            ),
            /*BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                return ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        BlocProvider.of<AuthBloc>(context).add(RegisterUser(
                            name: txtName.text.trim(),
                            email: txtEmail.text.trim(),
                            phoneno: txtPhone.text.trim(),
                            password: txtPassword.text.trim()));
                        if (state.result == 'success') {
                          Navigator.of(context).pop();
                        }
                      }
                    },
                    child: const Text("Sign In"));
              },
            ),*/
            BlocListener<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state.result == 'success') {
                    Navigator.of(context)
                        .pop(); // Navigate when registration is successful
                  } else if (state.result == 'error') {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content:
                              Text('Registration failed: ${state.result}')),
                    );
                  }
                },
                child:
                    // BlocBuilder<AuthBloc, AuthState>(
                    //   builder: (context, state) {
                    //     return
                    ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      BlocProvider.of<AuthBloc>(context).add(RegisterUser(
                        name: txtName.text.trim(),
                        email: txtEmail.text.trim(),
                        phoneno: txtPhone.text.trim(),
                        password: txtPassword.text.trim(),
                      ));
                    }
                  },
                  child: const Text("Sign In"),
                )
                //   },
                // ),
                ),
            const Padding(
              padding: EdgeInsets.all(10),
              child: Text("* marked mandetory fields"),
            )
          ],
        ),
      ),
    );
  }
}
