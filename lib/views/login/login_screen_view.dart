import 'package:flutter/material.dart';

import '../../widgets/login/login_screen_widget.dart';
import 'package:androidproject/controller/login/login_screen_controller.dart';

import '../../widgets/login/register_widget.dart';
import '../../widgets/login/sign_in_widget.dart';

class LoginScreenView extends StatelessWidget {
  final LoginScreenController state;
  LoginScreenWidget get widget => state.widget;

  const LoginScreenView(this.state, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Background color of the screen.
      backgroundColor: widget.backgroundColor,
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
                controller: widget.tabController, // Assigning the TabController.
                labelColor: Colors.white, // Text color of the selected tabs.
                unselectedLabelColor: Colors.white54, // Text color of the unselected tabs.
                indicator: BoxDecoration(
                  color: widget.indicatorColor, // Background color of the indicator.
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
              color: widget.indicatorColor,
            ),

            // Assign tabs and widgets.
            Expanded(
              // TabBarView displays the content of the selected tabs.
              child: TabBarView(
                controller: widget.tabController, // Assigning the TabController.
                children: [
                  // Pass the background color to the SignInForm widget.
                  SignInWidget(backgroundColor: widget.indicatorColor),
                  // Pass the background color to the RegisterForm widget.
                  RegisterWidget(backgroundColor: widget.indicatorColor),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}