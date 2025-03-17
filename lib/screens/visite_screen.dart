import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class VisiteScreen extends StatefulWidget {
  @override
  _VisiteScreenState createState() => _VisiteScreenState();
}

class _VisiteScreenState extends State<VisiteScreen> {
  List<dynamic> visites = [];

  Future<void> importerVisites() async {
    final url = Uri.parse('http://www.btssio-carcouet.fr/ppe4/public/mesvisites/3');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        setState(() {
          visites = json.decode(response.body);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Importation réussie !')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Échec de l\'importation, erreur ${response.statusCode}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur : $e')),
      );
    }
  }

  String formatDate(String dateStr) {
    DateTime date = DateTime.parse(dateStr);
    return DateFormat("dd/MM/yyyy à HH:mm").format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Importer des visites'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: importerVisites,
            child: Text('Importer'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: visites.length,
              itemBuilder: (context, index) {
                final visite = visites[index];
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Visite ID : ${visite['id']},  Avec le patient : ${visite['patient']}",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Date : ${formatDate(visite['date_prevue'])}  Durée : ${visite['duree']} min",
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
