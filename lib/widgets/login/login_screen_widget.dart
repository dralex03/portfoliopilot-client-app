import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../controller/login/login_screen_controller.dart';

class LoginScreenWidget extends StatefulWidget {
  late TabController tabController; // TabController to manage the tabs.
  final Color indicatorColor; // Color of the indicator.
  final Color backgroundColor; // Color of the main background.

  LoginScreenWidget({super.key, required this.backgroundColor, required this.indicatorColor});

  @override
  LoginScreenController createState() => LoginScreenController();
}