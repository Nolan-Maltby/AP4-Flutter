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
  StreamSubscription<Position>? _positionSubscription;
  bool isLoading = true;
  MapController mapController = MapController();

  @override
  void initState() {
    super.initState();
    _initMap();
  }

  Future<void> _initMap() async {
    await _fetchPatientCoordinates();
    await _handleLocationPermissionAndStartStream();
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

      final response =
          await http.get(url).timeout(Duration(seconds: 5)); // Timeout

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
      print('Erreur lors du géocodage : $e');
    }
  }

  Future<void> _handleLocationPermissionAndStartStream() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      _showLocationErrorDialog(
          'La localisation est désactivée. Veuillez l’activer dans les paramètres.');
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever ||
        permission == LocationPermission.denied) {
      _showLocationErrorDialog(
          'Permission de localisation refusée. Veuillez l’autoriser dans les paramètres.');
      return;
    }

    _positionSubscription = Geolocator.getPositionStream(
      locationSettings: LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 5,
      ),
    ).listen((Position position) {
      if (mounted) {
        setState(() {
          myPosition = LatLng(position.latitude, position.longitude);
        });
      }
    });
  }

  void _showLocationErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Localisation désactivée'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              Geolocator.openLocationSettings(); // Ouvre les réglages GPS
            },
            child: Text('Ouvrir les paramètres'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _positionSubscription?.cancel(); // Ne plante pas si null
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Carte du Patient')),
      body: isLoading || patientPosition == null
          ? Center(child: CircularProgressIndicator())
          : FlutterMap(
              mapController: mapController,
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
