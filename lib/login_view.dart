import 'package:flutter/material.dart';
import 'package:integration_testing/home_view.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const TextField(
              decoration: InputDecoration(label: Text("Email")),
            ),
            const SizedBox(
              height: 10,
            ),
            const TextField(
              decoration: InputDecoration(label: Text("Password")),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: ((cxt) => const HomeView())));
                },
                child: const Text("Login"))
          ],
        ),
      )),
    );
  }
}
