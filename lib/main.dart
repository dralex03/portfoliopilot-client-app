import 'package:androidproject/services/service_locator.dart';
import 'package:androidproject/views/asset/add_asset_widget/add_asset_view.dart';
import 'package:androidproject/views/login/login_screen.dart';
import 'package:androidproject/views/profile/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:androidproject/utils/app_theme.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'views/dashboard/dashboard_view.dart';

Future<void> main() async {
  setupGetIt();
  await dotenv.load(fileName: ".env");
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
        '/add': (context) => const AddAssetScreen(),
        '/profile': (context) => ProfileView(email: 'lars_anton@icloud.com',),
    },
    );
  }
}
