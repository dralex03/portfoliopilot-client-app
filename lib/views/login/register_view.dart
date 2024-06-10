import 'package:flutter/material.dart';

import 'package:androidproject/utils/app_theme.dart';

import 'package:androidproject/controller/login_controller.dart';
import 'package:androidproject/services/service_locator.dart';

/// RegisterView, representing a registration form with logic.
class RegisterView extends StatelessWidget {
  RegisterView({super.key});

  final stateController = getIt<LoginScreenController>();
  // Controllers for the text fields.
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.backgroundColor,
      child: SingleChildScrollView(
        // ScrollView to ensure the content can be scrolled when the keyboard is open.
        child: Column(
          children: <Widget>[
            const SizedBox(height: 10),
            TextFormField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white.withOpacity(0.1),
                hintText: 'E-Mail...',
                hintStyle: const TextStyle(color: Colors.grey),
                prefixIcon: const Icon(Icons.person, color: Colors.white),
                border: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.all(16.0),
              ),
              style: const TextStyle(color: Colors.white),
              controller: emailController,
            ),

            // Space between the text fields.
            const SizedBox(height: 10),

            // Text field for the password.
            TextFormField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white.withOpacity(0.1),
                hintText: 'Password...',
                hintStyle: const TextStyle(color: Colors.grey),
                prefixIcon: const Icon(Icons.visibility, color: Colors.white),
                border: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.all(16.0),
              ),
              obscureText: true,
              style: const TextStyle(color: Colors.white),
              controller: passwordController,
            ),

            // Space between the text fields.
            const SizedBox(height: 10),

            // Text field to confirm the password.
            TextFormField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white.withOpacity(0.1),
                hintText: 'Confirm Password...',
                hintStyle: const TextStyle(color: Colors.grey),
                prefixIcon: const Icon(Icons.lock, color: Colors.white),
                border: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.all(16.0),
              ),
              obscureText: true,
              style: const TextStyle(color: Colors.white),
              controller: confirmPasswordController,
            ),

            // Space between the last text field and the button.
            const SizedBox(height: 10),

            // Button to register.
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  // Handle registration logic.
                  var res = await stateController.register(emailController.text, passwordController.text, confirmPasswordController.text);
                  if (res["success"]) {
                    // TODO: Redirect to dashboard.
                  } else {
                    final snackBar = SnackBar(
                      content: Text(res["message"]),
                      backgroundColor: AppColors.negativeColor,
                    );

                    // Find the ScaffoldMessenger in the widget tree
                    // and use it to show a SnackBar.
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.white,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                ),
                child: const Text(
                  'Register',
                  style: TextStyle(
                    fontFamily: 'Lato',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
