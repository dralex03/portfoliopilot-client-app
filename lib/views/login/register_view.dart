import 'package:flutter/material.dart';

import '../../app_theme.dart';
import '../../controller/login_controller.dart';
import '../../services/service_locator.dart';

// RegisterView, representing a registration form.
class RegisterView extends StatelessWidget {
  RegisterView({super.key});

  final stateController = getIt<LoginScreenController>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      // Set the background color of the container to the provided color.
      color: AppColors.backgroundColor,
      child: SingleChildScrollView(
        // ScrollView to ensure the content can be scrolled when the keyboard is open.
        child: Column(
          children: <Widget>[

            // Text field for the username.
            TextFormField(
              decoration: InputDecoration(
                // Fill the text field with a semi-transparent color.
                filled: true,
                fillColor: Colors.white.withOpacity(0.1),
                hintText: 'E-Mail-Adresse ...', // Placeholder text.
                prefixIcon: Icon(Icons.person, color: Colors.white), // Icon on the left in the text field.
                border: OutlineInputBorder(
                  borderSide: BorderSide.none, // No border for the text field.
                ),
                contentPadding: EdgeInsets.all(16.0), // Inner padding in the text field.
              ),
              style: TextStyle(color: Colors.white), // Text color in the text field.
              controller: emailController
            ),

            // Space between the text fields.
            SizedBox(height: 10),

            // Text field for the password.
            TextFormField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white.withOpacity(0.1),
                hintText: 'Password...', // Placeholder text.
                prefixIcon: Icon(Icons.visibility, color: Colors.white), // Icon on the left in the text field.
                border: OutlineInputBorder(
                  borderSide: BorderSide.none, // No border for the text field.
                ),
                contentPadding: EdgeInsets.all(16.0), // Inner padding in the text field.
              ),
              obscureText: true, // Hide the entered password.
              style: TextStyle(color: Colors.white), // Text color in the text field.
              controller: passwordController
            ),

            // Space between the last text field and the button.
            SizedBox(height: 10),

            // Text field to confirm the password.
            TextFormField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white.withOpacity(0.1),
                hintText: 'Confirm Password...', // Placeholder text.
                prefixIcon: Icon(Icons.lock, color: Colors.white), // Icon on the left in the text field.
                border: OutlineInputBorder(
                  borderSide: BorderSide.none, // No border for the text field.
                ),
                contentPadding: EdgeInsets.all(16.0), // Inner padding in the text field.
              ),
              obscureText: true, // Hide the entered password.
              style: TextStyle(color: Colors.white), // Text color in the text field.
                controller: confirmPasswordController
            ),

            // Space between the last text field and the button.
            SizedBox(height: 10),

            // Button to register.
            SizedBox(
              width: double.infinity, // Button takes the full width of the container.
              child: ElevatedButton(
                onPressed: () async {
                  var res = await stateController.register(emailController.text, passwordController.text, confirmPasswordController.text);
                  if(res["success"]) {
                    // TODO: Redirect to dashboard
                  } else {
                    final snackBar = SnackBar(
                      content: Text(res["message"]),
                      backgroundColor: Colors.red,
                    );

                    // Find the ScaffoldMessenger in the widget tree
                    // and use it to show a SnackBar
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal, // Background color of the button
                  foregroundColor: Colors.white, // Text color of the button
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero, // Do not round the corners
                  ),
                ),
                child: Text('Register'), // Text in the button.
              ),
            ),
          ],
        ),
      ),
    );
  }
}
