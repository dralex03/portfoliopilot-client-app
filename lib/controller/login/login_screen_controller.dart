import 'package:androidproject/views/login/login_screen_view.dart';
import 'package:androidproject/widgets/login/login_screen_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginScreenController extends State<LoginScreenWidget> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) => LoginScreenView(this);

  @override
  void initState() {
    super.initState();
    // Initialisierung des TabControllers mit zwei Tabs.
    widget.tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    // Freigabe der Ressourcen des TabControllers.
    widget.tabController.dispose();
    super.dispose();
  }

  register() {

  }
}