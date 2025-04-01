import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ap4_android_application/models/visite.dart';
import 'package:ap4_android_application/screens/patient_screen.dart';

class VisiteScreen extends StatefulWidget {
  @override
  _VisiteScreenState createState() => _VisiteScreenState();
}

class _VisiteScreenState extends State<VisiteScreen> {
  late Future<Box<Visite>> _visiteBoxFuture;
  Map<int, String> patientNames = {};

  @override
  void initState() {
    super.initState();
    _visiteBoxFuture = _openBox();
  }

  Future<Box<Visite>> _openBox() async {
    return await Hive.openBox<Visite>('visites');
  }

  Future<String> fetchPatientName(int patientId) async {
    if (patientNames.containsKey(patientId)) {
      return patientNames[patientId]!;
    }
    try {
      final response = await http.get(
        Uri.parse('http://www.btssio-carcouet.fr/ppe4/public/personne/$patientId'),
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final fullName = "${data['nom']} ${data['prenom']}";
        patientNames[patientId] = fullName;
        return fullName;
      }
    } catch (e) {
      print("Erreur lors de la récupération du patient : $e");
    }
    return "Inconnu";
  }

  String formatDate(String dateStr) {
    DateTime date = DateTime.parse(dateStr);
    return DateFormat("dd/MM/yyyy à HH:mm").format(date);
  }

  Future<void> importerVisites() async {
    final url = Uri.parse('http://www.btssio-carcouet.fr/ppe4/public/mesvisites/3');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        var box = await Hive.openBox<Visite>('visites');
        for (var item in data) {
          final visite = Visite(
            id: item['id'],
            patient: item['patient'],
            datePrevue: item['date_prevue'],
            duree: item['duree'],
          );
          box.put(visite.id, visite);
        }
        setState(() {});
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Importation réussie !')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur ${response.statusCode}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur : $e')),
      );
    }
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
            child: FutureBuilder<Box<Visite>>(
              future: _visiteBoxFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Erreur: ${snapshot.error}'));
                }

                var box = snapshot.data;
                if (box == null || box.isEmpty) {
                  return Center(child: Text('Aucune visite enregistrée'));
                }

                return ValueListenableBuilder(
                  valueListenable: box.listenable(),
                  builder: (context, Box<Visite> box, _) {
                    return ListView.builder(
                      itemCount: box.length,
                      itemBuilder: (context, index) {
                        final visite = box.getAt(index);
                        return FutureBuilder<String>(
                          future: fetchPatientName(visite!.patient),
                          builder: (context, nameSnapshot) {
                            final patientName = nameSnapshot.data ?? "Chargement...";
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PatientScreen(patientId: visite.patient),
                                  ),
                                );
                              },
                              child: Container(
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
                                      "Visite ID : ${visite.id}, Avec le patient : $patientName",
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "Date : ${formatDate(visite.datePrevue)}  Durée : ${visite.duree} min",
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}