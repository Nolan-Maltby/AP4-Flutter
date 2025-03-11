import 'package:flutter/material.dart';
import 'package:ap4_android_application/services/storage_service.dart';

class ThirdScreen extends StatefulWidget {
  const ThirdScreen({Key? key}) : super(key: key);

  @override
  _ThirdScreenState createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    // Charger les données utilisateur
  }

  void _logout() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Kaliémie"),
        centerTitle: false,
        actions: [
          Row(
            children: [
              Image.asset('assets/images/ilist.jpg', width: 30, height: 30),
              SizedBox(width: 10),
              Image.asset('assets/images/iimport.jpg', width: 30, height: 30),
              SizedBox(width: 10),
              PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == 'logout') {
                    _logout();
                  }
                },
                itemBuilder: (BuildContext context) {
                  return [
                    PopupMenuItem(
                      value: 'logout',
                      child: Text('Déconnexion'),
                    ),
                  ];
                },
                child: Icon(Icons.more_vert),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 50), // Ajout d'un espace avant l'image
          SizedBox(
            height: 250,
            child: Image.asset(
              'assets/images/medicalpng.png',
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Center(
              // contenu de la page
            ),
          ),
        ],
      ),
    );
  }
}