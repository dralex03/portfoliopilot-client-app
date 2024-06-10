import 'package:flutter/material.dart';

import 'package:androidproject/utils/app_theme.dart';
import 'package:androidproject/controller/login_controller.dart';
import 'package:androidproject/services/service_locator.dart';
import 'login/register_view.dart';
import 'login/sign_in_view.dart';

/// LoginScreen is a stateful widget that provides a login and registration interface.
class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

/// _LoginScreenState is the state class for LoginScreen.
class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  // State controller for managing login logic.
  final stateController = getIt<LoginScreenController>();
  // TabController to manage the tabs.
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    // Dispose the TabController to free up resources.
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.backgroundColor,
              AppColors.gradientColor,
            ],
            stops: [0.25, 1],
          ),
        ),
        // Removing Padding around the child widgets.
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              SizedBox(height: MediaQuery.of(context).size.height * 0.1),

              const Text(
                'Welcome to PortfolioPilot',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 50,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 20),

              // Container for the design of the two tabs.
              Container(
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                ),
                child: TabBar(
                  controller: tabController,
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.white54,
                  indicator: const BoxDecoration(
                    color: AppColors.backgroundColor,
                  ),
                  indicatorSize: TabBarIndicatorSize.tab,
                  labelStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Lato',
                  ),
                  tabs: const [
                    Tab(text: 'Sign-In'), // Tab for sign-in.
                    Tab(text: 'Register'), // Tab for registration.
                  ],
                ),
              ),

              // Assign tabs and widgets.
              Expanded(
                child: TabBarView(
                  controller: tabController,
                  children: [
                    // Sign-in view widget.
                    SignInView(),
                    // Register view widget.
                    RegisterView(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
