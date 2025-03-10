import 'package:flutter/material.dart';
import 'package:ap4_android_application/services/storage_service.dart';

class ThirdScreen extends StatefulWidget {
  const ThirdScreen({Key? key}) : super(key: key);

  @override
  _ThirdScreenState createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  String? nom;
  String? prenom;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    Map<String, dynamic>? userData = await StorageService.getUserData();
    setState(() {
      nom = userData?['nom'];
      prenom = userData?['prenom'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Bienvenue sur Kaliémie")),
      body: Center(
        child: Text("Bienvenue, ${prenom ?? "Utilisateur"} ${nom ?? ""}"),
      ),
    );
  }
}
