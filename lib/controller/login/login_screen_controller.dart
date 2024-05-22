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
    // Initialization of the TabController with two tabs.
    widget.tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    // Release the resources of the TabController.
    widget.tabController.dispose();
    super.dispose();
  }

  register() {

  }
}