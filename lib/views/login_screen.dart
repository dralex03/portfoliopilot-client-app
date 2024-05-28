
import 'package:androidproject/main.dart';
import 'package:flutter/material.dart';

import '../app_theme.dart';
import '../controller/login_controller.dart';
import '../services/service_locator.dart';
import 'login/register_view.dart';
import 'login/sign_in_view.dart';

class LoginScreen extends StatefulWidget {

  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  final stateController = getIt<LoginScreenController>();
  late TabController tabController; // TabController to manage the tabs.

  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Background color of the screen.
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(0), // No additional padding.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Center the content vertically.
          children: <Widget>[

            // Placeholder to push the text down a bit.
            SizedBox(height: MediaQuery
                .of(context)
                .size
                .height * 0.1),

            // Welcome text.
            Text(
              'Welcome to PortfolioPilot',
              style: TextStyle(
                color: Colors.white,
                fontSize: 50,
              ),
              textAlign: TextAlign.center,
            ),

            // Space between text and TabBar.
            SizedBox(height: 20),

            // Container for the design of the two tabs.
            Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1), // Background color of the TabBar with transparency.
              ),
              child: TabBar(
                controller: tabController, // Assigning the TabController.
                labelColor: Colors.white, // Text color of the selected tabs.
                unselectedLabelColor: Colors.white54, // Text color of the unselected tabs.
                indicator: BoxDecoration(
                  color: AppColors.backgroundColor, // Background color of the indicator.
                ),
                indicatorSize: TabBarIndicatorSize.tab, // Adjust the indicator size to the tab size.
                tabs: [
                  Tab(text: 'Sign-In'), // Tab for sign-in.
                  Tab(text: 'Register'), // Tab for registration.
                ],
              ),
            ),

            // Add a colored line under the TabBar as a "Sized Box".
            Container(
              height: 10,
              color: AppColors.backgroundColor,
            ),

            // Assign tabs and widgets.
            Expanded(
              // TabBarView displays the content of the selected tabs.
              child: TabBarView(
                controller: tabController, // Assigning the TabController.
                children: [
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
    );
  }
}