import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'dart:async';

class PatientMapScreen extends StatefulWidget {
  final Map<String, dynamic> patientData;

  const PatientMapScreen({required this.patientData});

  @override
  _PatientMapScreenState createState() => _PatientMapScreenState();
}

class _PatientMapScreenState extends State<PatientMapScreen> {
  LatLng? patientPosition;
  LatLng? myPosition;
  late StreamSubscription<Position> _positionSubscription;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _initMap();
  }

  Future<void> _initMap() async {
    await _fetchPatientCoordinates();
    _startLocationStream();
    setState(() {
      isLoading = false;
    });
  }

  Future<void> _fetchPatientCoordinates() async {
    try {
      String adresseComplete =
          "${widget.patientData['ad1']}, ${widget.patientData['cp']} ${widget.patientData['ville']}";

      final url = Uri.parse(
          'https://api-adresse.data.gouv.fr/search/?q=${Uri.encodeComponent(adresseComplete)}&limit=1');

      final response = await http.get(url).timeout(Duration(seconds: 5)); // Timeout ajouté

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data != null &&
            data['features'] != null &&
            data['features'].length > 0) {
          final coordinates = data['features'][0]['geometry']['coordinates'];
          final longitude = coordinates[0];
          final latitude = coordinates[1];

          patientPosition = LatLng(latitude, longitude);
        } else {
          print('Adresse introuvable via api-adresse.data.gouv.fr');
        }
      } else {
        print('Erreur API : ${response.statusCode}');
      }
    } catch (e) {
      print('Erreur lors du géocodage avec api-adresse.data.gouv.fr : $e');
    }
  }

  void _startLocationStream() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print("GPS désactivé.");
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print("Permission refusée.");
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      print("Permission refusée définitivement.");
      return;
    }

    _positionSubscription = Geolocator.getPositionStream(
      locationSettings: LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 5, // mise à jour si l'utilisateur bouge d'au moins 5m
      ),
    ).listen((Position position) {
      if (mounted) {
        setState(() {
          myPosition = LatLng(position.latitude, position.longitude);
        });
      }
    });
  }

  @override
  void dispose() {
    _positionSubscription.cancel(); // Arrêter le stream quand l'écran est fermé
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Carte du Patient')),
      body: isLoading || patientPosition == null
          ? Center(child: CircularProgressIndicator())
          : FlutterMap(
              options: MapOptions(
                center: patientPosition,
                zoom: 16.0,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.app',
                ),
                MarkerLayer(
                  markers: [
                    // Marqueur du patient
                    Marker(
                      width: 80.0,
                      height: 80.0,
                      point: patientPosition!,
                      builder: (ctx) => Column(
                        children: [
                          Text(
                            'Patient',
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Icon(
                            Icons.location_on,
                            color: Colors.red,
                            size: 40,
                          ),
                        ],
                      ),
                    ),
                    // Marqueur de l'infirmier (si position obtenue)
                    if (myPosition != null)
                      Marker(
                        width: 80.0,
                        height: 80.0,
                        point: myPosition!,
                        builder: (ctx) => Column(
                          children: [
                            Text(
                              'Moi',
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Icon(
                              Icons.person_pin_circle,
                              color: Colors.blue,
                              size: 40,
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ],
            ),
    );
  }
}
