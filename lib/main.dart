import 'package:flutter/material.dart';
import 'package:ap4_android_application/screens/first_screen.dart';
import 'package:ap4_android_application/screens/second_screen.dart';
import 'package:ap4_android_application/screens/third_screen.dart';
import 'package:ap4_android_application/services/permissions_service.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ap4_android_application/models/visite.dart';
import 'package:ap4_android_application/models/credentials.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(VisiteAdapter());
  Hive.registerAdapter(CredentialsAdapter());

  await Hive.openBox<Visite>('visites');
  await Hive.openBox<Credentials>('credentials');

  final credsBox = Hive.box<Credentials>('credentials');
  final creds = credsBox.get('user');

  runApp(MyApp(
    initialRoute: creds != null ? '/third' : '/',
  ));

  PermissionsService.requestPermissions();
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  const MyApp({Key? key, required this.initialRoute}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AP4 - Kaliémie',
      initialRoute: initialRoute,
      routes: {
        '/': (context) => FirstScreen(),
        '/second': (context) => SecondScreen(),
        '/third': (context) => ThirdScreen(),
      },
    );
  }
}
