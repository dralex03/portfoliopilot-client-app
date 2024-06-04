import 'package:flutter/material.dart';

import 'package:androidproject/utils/app_theme.dart';
import '../../controller/login_controller.dart';
import '../../services/service_locator.dart';
import 'login_widget/register_view.dart';
import 'login_widget/sign_in_view.dart';

/// The main screen for user authentication, providing options for sign-in and registration.
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  // Controller for managing the state of the login screen.
  final stateController = getIt<LoginScreenController>();
  // TabController to manage the tabs.
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    // Initialize TabController with two tabs.
    tabController = TabController(vsync: this, length: 2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Background color of the screen.
      backgroundColor: AppColors.backgroundColor,
      body: Container(
        // Decoration with a linear gradient background.
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

        // Padding around the child widgets.
        child: Padding(
          padding: const EdgeInsets.all(0), // No additional padding.
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Center the content vertically.
            children: <Widget>[
              // Placeholder to push the text down a bit.
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),

              // Welcome text.
              const Text(
                'Welcome to PortfolioPilot',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 50,
                ),
                textAlign: TextAlign.center,
              ),

              // Space between text and TabBar.
              const SizedBox(height: 20),

              // Container for the design of the two tabs.
              Container(
                decoration: const BoxDecoration(
                  color: Colors.transparent, // Background color of the TabBar with transparency.
                ),
                child: TabBar(
                  controller: tabController, // Assigning the TabController.
                  labelColor: Colors.white, // Text color of the selected tabs.
                  unselectedLabelColor: Colors.white54, // Text color of the unselected tabs.
                  indicator: const BoxDecoration(
                    color: AppColors.backgroundColor, // Background color of the indicator.
                  ),
                  indicatorSize: TabBarIndicatorSize.tab, // Adjust the indicator size to the tab size.
                  labelStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Lato',
                  ), // Font style of the labels.
                  tabs: const [
                    Tab(text: 'Sign-In'), // Tab for sign-in.
                    Tab(text: 'Register'), // Tab for registration.
                  ],
                ),
              ),

              // Assign tabs and widgets.
              Expanded(
                // TabBarView displays the content of the selected tabs.
                child: TabBarView(
                  controller: tabController, // Assigning the TabController.
                  children: const [
                    // Pass the background color to the SignInForm widget.
                    SignInView(),
                    // Pass the background color to the RegisterForm widget.
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
