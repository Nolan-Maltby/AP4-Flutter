import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class PatientScreen extends StatefulWidget {
  final int patientId;

  PatientScreen({required this.patientId});

  @override
  _PatientScreenState createState() => _PatientScreenState();
}

class _PatientScreenState extends State<PatientScreen> {
  bool soin1Realise = false;
  bool soin2Realise = false;
  DateTime? dateReelle = DateTime(2019, 1, 15);
  DateTime? datePrevue = DateTime(2019, 1, 15);
  Map<String, dynamic>? patientData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchPatientData();
  }

  Future<void> fetchPatientData() async {
    final response = await http.get(
      Uri.parse(
        'http://www.btssio-carcouet.fr/ppe4/public/personne/${widget.patientId}',
      ),
    );
    if (response.statusCode == 200) {
      setState(() {
        patientData = json.decode(response.body);
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: dateReelle ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != dateReelle) {
      setState(() {
        dateReelle = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Visite sélectionnée")),
      body:
          isLoading
              ? Center(child: CircularProgressIndicator())
              : patientData == null
              ? Center(child: Text("Erreur de chargement des données"))
              : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Visite :",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "Date prévue : ${DateFormat("dd/MM/yyyy").format(datePrevue!)}",
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Text("Date Réelle :", style: TextStyle(fontSize: 16)),
                          SizedBox(width: 8),
                          InkWell(
                            onTap: () => _selectDate(context),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                vertical: 5,
                                horizontal: 8,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Text(
                                DateFormat("dd/MM/yyyy").format(dateReelle!),
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Divider(),
                      SizedBox(height: 5),
                      Text(
                        "Patient :",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                      Text(
                        "${patientData!['nom']} ${patientData!['prenom']}",
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        "${patientData!['ad1']}",
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        "${patientData!['cp']} ${patientData!['ville']}",
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        "Port : ${patientData!['tel_port']} - Fixe : ${patientData!['tel_fixe']}",
                        style: TextStyle(fontSize: 16),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Afficher carte MAP',
                                ),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          },
                          child: Text("MAP"),
                        ),
                      ),

                      Divider(),
                      SizedBox(height: 5),
                      Text(
                        "Commentaire :",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                      TextField(
                        decoration: InputDecoration(
                          hintText: "Commentaire Visite",
                          border: OutlineInputBorder(),
                        ),
                        maxLines: 3,
                      ),
                      Divider(),
                      SizedBox(height: 5),
                      Text(
                        "Soins :",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                      CheckboxListTile(
                        title: Text("Injection sous-cutanée"),
                        value: soin1Realise,
                        onChanged: (bool? value) {
                          setState(() {
                            soin1Realise = value ?? false;
                          });
                        },
                      ),
                      CheckboxListTile(
                        title: Text("Lavage d'un sinus"),
                        value: soin2Realise,
                        onChanged: (bool? value) {
                          setState(() {
                            soin2Realise = value ?? false;
                          });
                        },
                      ),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Sauvegarde effectuée !'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          },
                          child: Text("SAUVEGARDER"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
    );
  }
}
