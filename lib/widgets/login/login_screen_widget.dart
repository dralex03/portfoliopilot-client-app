import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../controller/login/login_screen_controller.dart';

class LoginScreenWidget extends StatefulWidget {
  late TabController tabController; // TabController zur Verwaltung der Tabs.
  final Color indicatorColor; // Farbe des Indikators.
  final Color backgroundColor;// Farbe des Main-Hintergrunds.

  LoginScreenWidget({super.key, required this.backgroundColor, required this.indicatorColor});

  @override
  LoginScreenController createState() => LoginScreenController();
}