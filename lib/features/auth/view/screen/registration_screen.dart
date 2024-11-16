import 'package:expense_app/features/auth/view/screen/login_screen.dart';
import 'package:flutter/material.dart';

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

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
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: txtName,
                validator: (value) {
                  return (value != null && value.isEmpty) ? 'Enter Name' : null;
                },
                decoration: const InputDecoration(
                    hintText: "Full Name", border: OutlineInputBorder()),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: txtEmail,
                validator: (value) {
                  return (value != null && value.isEmpty)
                      ? 'Enter valid email'
                      : null;
                },
                decoration: const InputDecoration(
                    hintText: "Email", border: OutlineInputBorder()),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
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
              padding: const EdgeInsets.all(8.0),
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
            ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) {
                      return const LoginScreen();
                    }));
                  }
                },
                child: const Text("Sign In"))
          ],
        ),
      ),
    );
  }
}
