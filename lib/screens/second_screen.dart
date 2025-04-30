import 'package:flutter/material.dart';
import 'package:ap4_android_application/services/api_service.dart';
import 'package:ap4_android_application/services/storage_service.dart';
import 'package:ap4_android_application/screens/third_screen.dart';
import 'package:hive/hive.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'package:ap4_android_application/models/credentials.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String hashPassword(String password) {
    return sha256.convert(utf8.encode(password)).toString();
  }

  Future<void> _login() async {
    String username = _loginController.text.trim();
    String password = _passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      _showErrorDialog("Veuillez entrer un identifiant et un mot de passe");
      return;
    }

    final userData = await ApiService.login(username, password);

    if (userData != null) {
      await StorageService.saveUserData(userData);

      // Stocker les identifiants
      final credsBox = Hive.box<Credentials>('credentials');
      await credsBox.put('user', Credentials(
        login: username,
        passwordHash: hashPassword(password),
      ));

      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const ThirdScreen(),
        ),
      );
    } else {
      _showErrorDialog("Identifiant ou mot de passe incorrect");
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Erreur de connexion"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Connexion", style: TextStyle(color: Colors.black)),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _loginController,
              decoration: InputDecoration(labelText: "Identifiant"),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: "Mot de passe"),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text("Se connecter"),
              onPressed: _login,
            ),
          ],
        ),
      ),
    );
  }
}
