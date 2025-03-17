import 'package:flutter/material.dart';

class VisiteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Importer des visites'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
          },
          child: Text('Importer'),
        ),
      ),
    );
  }
}