import 'package:flutter/material.dart';
import 'package:ap4_android_application/services/storage_service.dart';
import 'package:ap4_android_application/services/permissions_service.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:ap4_android_application/screens/visite_screen.dart';

class ThirdScreen extends StatefulWidget {
  const ThirdScreen({Key? key}) : super(key: key);

  @override
  _ThirdScreenState createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  String _userName = "";

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final userData = await StorageService.getUserData();
    if (userData != null && userData.containsKey('prenom')) {
      setState(() {
        _userName = userData['prenom'];
      });
    }
  }

  void _logout() {
    Navigator.pop(context);
  }

  Future<void> _showPermissionsDialog() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
      Permission.contacts,
    ].request();

    String permissionsText = statuses.entries.map((entry) {
      return "${entry.key}: ${entry.value.isGranted ? 'Ok' : 'Refusée'}";
    }).join("\n");

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text("Permissions accordées"),
          content: Text(permissionsText),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  void _navigateToVisiteScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => VisiteScreen()),
    );
  }

  Future<void> _showExportDialog() async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text("Exporter"),
          content: Text("Exporter"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("OK"),
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
        automaticallyImplyLeading: false,
        title: Text("Kaliémie"),
        centerTitle: false,
        actions: [
          Row(
            children: [
              GestureDetector(
                onTap: _showPermissionsDialog,
                child: Image.asset('assets/images/ilist.jpg', width: 30, height: 30),
              ),
              SizedBox(width: 10),
              GestureDetector(
                onTap: _navigateToVisiteScreen,
                child: Image.asset('assets/images/iimport.jpg', width: 30, height: 30),
              ),
              SizedBox(width: 10),
              PopupMenuButton<String>(
                color: Colors.white,
                onSelected: (value) {
                  if (value == 'export') {
                    _showExportDialog();
                  } else if (value == 'logout') {
                    _logout();
                  }
                },
                itemBuilder: (BuildContext context) {
                  return [
                    PopupMenuItem(
                      value: 'export',
                      child: Text('Exporter les données'),
                    ),
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
          SizedBox(height: 50),
          SizedBox(
            height: 250,
            child: Image.asset(
              'assets/images/medicalpng.png',
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 50),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Bienvenue, $_userName',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
