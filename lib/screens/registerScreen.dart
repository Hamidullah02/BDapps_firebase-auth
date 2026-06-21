import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../routes.dart';

class registerScreen extends StatefulWidget {
  const registerScreen({super.key});

  @override
  State<registerScreen> createState() => _registerScreenState();
}

class _registerScreenState extends State<registerScreen> {
  final _emailContrlr = TextEditingController();
  final _passContrlr = TextEditingController();

  Future<void> login() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailContrlr.text.trim(),
        password: _passContrlr.text.trim(),
      );
      Get.toNamed(Approutes.QUIZSCREEN);
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
            ElevatedButton(onPressed: login, child: const Text("Register")),
            TextButton(
              onPressed: () => Get.toNamed(Approutes.LOGINSCREEN),
              child: const Text("already have an account? login here"),
            ),
          ],
        ),
      ),
    );
  }
}
