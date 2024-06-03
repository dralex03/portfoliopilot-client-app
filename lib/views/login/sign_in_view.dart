import 'package:flutter/material.dart';

import 'package:androidproject/utils/app_theme.dart';

// SignInView, representing a sign-in form.
class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // Set the background color of the container to the provided color.
      color: AppColors.backgroundColor,
      child: SingleChildScrollView(
        // ScrollView to ensure the content can be scrolled when the keyboard is open.
        child: Column(
          children: <Widget>[
            const SizedBox(height:10),
            // Text field for the username.
            TextFormField(
              decoration: InputDecoration(
                // Fill the text field with a semi-transparent color.
                filled: true,
                fillColor: Colors.white.withOpacity(0.1),
                hintText: 'Username...', // Placeholder text.
                hintStyle: const TextStyle(color: Colors.grey),
                prefixIcon: const Icon(Icons.person, color: Colors.white), // Icon on the left in the text field.
                border: const OutlineInputBorder(
                  borderSide: BorderSide.none, // No border for the text field.
                ),
                contentPadding: const EdgeInsets.all(16.0), // Inner padding in the text field.
              ),
              style: const TextStyle(color: Colors.white), // Text color in the text field.
            ),

            // Space between the text fields.
            const SizedBox(height: 10),

            // Text field for the password.
            TextFormField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white.withOpacity(0.1),
                hintText: 'Password...', // Placeholder text.
                hintStyle: const TextStyle(color: Colors.grey),
                prefixIcon: const Icon(Icons.visibility, color: Colors.white), // Icon on the left in the text field.
                border: const OutlineInputBorder(
                  borderSide: BorderSide.none, // No border for the text field.
                ),
                contentPadding: const EdgeInsets.all(16.0), // Inner padding in the text field.
              ),
              obscureText: true, // Hide the entered password.
              style: const TextStyle(color: Colors.white), // Text color in the text field.
            ),

            // Space between the last text field and the button.
            const SizedBox(height: 20),

            // Button to sign in.
            SizedBox(
              width: double.infinity, // Button takes the full width of the container.
              child: ElevatedButton(
                onPressed: () {
                  // Nach erfolgreichem Login
                Navigator.pushNamed(context, '/dashboard');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal, // Background color of the button
                  foregroundColor: Colors.white, // Text color of the button
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero, // Do not round the corners
                  ),
                ),
              child: const Text(
                    'Sign In',
                    style: TextStyle(
                    fontFamily: 'Lato', // Change to your desired font family
                    fontSize: 20, // Change to your desired font size
                    fontWeight: FontWeight.bold, // Change to your desired font weight
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
