import 'package:flutter/material.dart';
import 'package:ap4_android_application/screens/first_screen.dart';
import 'package:ap4_android_application/screens/second_screen.dart';
import 'package:ap4_android_application/screens/third_screen.dart';
import 'package:ap4_android_application/services/permissions_service.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ap4_android_application/models/visite.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(VisiteAdapter()); 
  await Hive.openBox<Visite>('visites');
  
  runApp(MyApp());
  PermissionsService.requestPermissions();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AP4 - Kaliémie',
      initialRoute: '/',
      routes: {
        '/': (context) => FirstScreen(),
        '/second': (context) => SecondScreen(),
        '/third': (context) => ThirdScreen(),
      },
    );
  }
}
