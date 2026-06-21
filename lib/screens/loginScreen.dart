import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../routes.dart';

class loginScreen extends StatefulWidget {
  loginScreen({super.key});

  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  final _emailContrlr = TextEditingController();
  final _passContrlr = TextEditingController();

  Future<void> login() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailContrlr.text.trim(),
        password: _passContrlr.text.trim(),
      );
      Get.offAllNamed(Approutes.QUIZSCREEN);
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Error", e.message ?? "Authentication failed");
    }
  }
  @override
  void dispose() {
    _emailContrlr.dispose();
    _passContrlr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailContrlr,
              decoration: const InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: _passContrlr,
              decoration: const InputDecoration(labelText: "Password"),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: login, child: const Text("Login")),
            TextButton(
              onPressed: () => Get.toNamed(Approutes.REGISTERSCREEN),
              child: const Text("Don't have an account? Register here"),
            ),
          ],
        ),
      ),
    );
  }
}
