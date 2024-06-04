import 'package:androidproject/services/service_locator.dart';
import 'package:androidproject/views/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:androidproject/utils/app_theme.dart';
import 'views/dashboard/dashboard_view.dart';

void main() {
  setupGetIt();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PortfolioPilot',
      theme: AppTheme.themeData,
      home: const LoginScreen(),
      routes: {
    '/dashboard': (context) => const DashboardView(),
    },
    );
  }
}
