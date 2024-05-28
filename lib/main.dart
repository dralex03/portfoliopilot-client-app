import 'package:androidproject/services/service_locator.dart';
import 'package:androidproject/views/login_screen.dart';
import 'package:flutter/material.dart';

void main() {
  setupGetIt();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Color indicatorColor = Color(0xFF252E3C); // Farbe des Indikators.
  final Color backgroundColor = Color(0xFF44556F);// Farbe des Main-Hintergrunds.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PortfolioPilot',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen()
    );
  }
}
