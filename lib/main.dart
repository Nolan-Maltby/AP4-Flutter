import 'package:flutter/material.dart';
import 'package:ap4_android_application/screens/first_screen.dart';
import 'package:ap4_android_application/screens/second_screen.dart';
import 'package:ap4_android_application/screens/third_screen.dart';
import 'package:ap4_android_application/services/permissions_service.dart';

void main() {
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
