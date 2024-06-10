import 'package:androidproject/services/service_locator.dart';
import 'package:androidproject/views/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  setupGetIt();
  await dotenv.load(fileName: ".env");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Color indicatorColor = Color(0xFF252E3C);
  final Color backgroundColor = Color(0xFF44556F);

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
