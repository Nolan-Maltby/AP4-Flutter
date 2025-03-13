import 'package:flutter/material.dart';
import 'package:ap4_android_application/services/storage_service.dart';
import 'package:ap4_android_application/services/permissions_service.dart';
import 'package:permission_handler/permission_handler.dart';

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
      return "${entry.key}: ${entry.value.isGranted ? '✅ Accordée' : '❌ Refusée'}";
    }).join("\n");

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
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

  Future<void> _showImportDialog() async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Importer"),
          content: Text("Importer"),
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
  Future<void> _showExportDialog() async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
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
      appBar: AppBar(
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
                onTap: _showImportDialog,
                child: Image.asset('assets/images/iimport.jpg', width: 30, height: 30),
              ),
              SizedBox(width: 10),
              PopupMenuButton<String>(
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
