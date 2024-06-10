import 'package:flutter/material.dart';

import 'package:androidproject/utils/app_theme.dart';
import 'package:androidproject/controller/login_controller.dart';
import 'package:androidproject/services/service_locator.dart';

/// SignInView, representing a sign-in form with logic.
class SignInView extends StatelessWidget {
  SignInView({super.key});

  final stateController = getIt<LoginScreenController>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.backgroundColor,
      child: SingleChildScrollView(
        // ScrollView to ensure the content can be scrolled when the keyboard is open.
        child: Column(
          children: <Widget>[
            const SizedBox(height:10),
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

            // Space between the last text field and the button.
            const SizedBox(height: 20),

            // Button to sign in.
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  var res = await stateController.login(emailController.text, passwordController.text);
                  if(res["success"]) {
                    // TODO: Redirect to dashboard
                  } else {
                    final snackBar = SnackBar(
                      content: Text(res["message"]),
                      backgroundColor: AppColors.negativeColor,
                    );

                    // Find the ScaffoldMessenger in the widget tree
                    // and use it to show a SnackBar
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.white,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),// Making Register/SignIn Button full Size
                ),
                child: const Text('Sign In',
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
