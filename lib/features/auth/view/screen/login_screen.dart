import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(hintText: "Username"),
              onChanged: (value) {},
            ),
            TextField(
              decoration: const InputDecoration(hintText: "Password"),
              onChanged: (value) {},
            ),
            ElevatedButton(onPressed: () {}, child: const Text("Login"))
          ],
        ),
      ),
    );
  }
}
