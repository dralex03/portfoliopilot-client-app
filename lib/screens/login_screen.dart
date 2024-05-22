import 'package:flutter/material.dart';
import '../widgets/sign_in_form.dart';
import '../widgets/register_form.dart';

// LoginScreen Widget, representing the main login page.
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController; // TabController to manage the tabs.
  final Color indicatorColor = Color(0xFF252E3C); // Color of the indicator.
  final Color backgroundColor = Color(0xFF44556F); // Color of the main background.

  @override
  void initState() {
    super.initState();
    // Initialization of the TabController with two tabs.
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    // Release the resources of the TabController.
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Background color of the screen.
      backgroundColor: backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(0), // No additional padding.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Center the content vertically.
          children: <Widget>[

            // Placeholder to push the text down a bit.
            SizedBox(height: MediaQuery.of(context).size.height * 0.1),

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
                controller: _tabController, // Assigning the TabController.
                labelColor: Colors.white, // Text color of the selected tabs.
                unselectedLabelColor: Colors.white54, // Text color of the unselected tabs.
                indicator: BoxDecoration(
                  color: indicatorColor, // Background color of the indicator.
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
              color: indicatorColor,
            ),

            // Assign tabs and widgets.
            Expanded(
              // TabBarView displays the content of the selected tabs.
              child: TabBarView(
                controller: _tabController, // Assigning the TabController.
                children: [
                  // Pass the background color to the SignInForm widget.
                  SignInForm(backgroundColor: indicatorColor),
                  // Pass the background color to the RegisterForm widget.
                  RegisterForm(backgroundColor: indicatorColor),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
