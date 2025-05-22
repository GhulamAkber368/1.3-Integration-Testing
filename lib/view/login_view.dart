import 'package:flutter/material.dart';
import 'package:integration_testing/view/home_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController emailTEContr = TextEditingController();
  TextEditingController passTEContr = TextEditingController();

  login() {
    if (emailTEContr.text.trim() == "Email" &&
        passTEContr.text.trim() == "Password") {
      Navigator.push(
          context, MaterialPageRoute(builder: ((cxt) => const HomeView())));
    } else {
      showDialog(
          context: context,
          builder: (BuildContext cxt) {
            return AlertDialog(
              title: const Text("Error"),
              content: const Text("Invalid Email or Password"),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Ok"))
              ],
            );
          });
    }
  }

  @override
  void dispose() {
    super.dispose();
    emailTEContr.dispose();
    passTEContr.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailTEContr,
              decoration: const InputDecoration(label: Text("Email")),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: passTEContr,
              decoration: const InputDecoration(label: Text("Password")),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(onPressed: login, child: const Text("Login"))
          ],
        ),
      )),
    );
  }
}
