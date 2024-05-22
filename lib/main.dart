import 'package:androidproject/widgets/login/login_screen_widget.dart';
import 'package:flutter/material.dart';

void main() {
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
      home: LoginScreenWidget(backgroundColor: backgroundColor, indicatorColor: indicatorColor)
    );
  }
}
