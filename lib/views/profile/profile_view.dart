import 'package:androidproject/controller/profile_controller.dart';
import 'package:androidproject/services/service_locator.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:androidproject/utils/app_theme.dart';
import 'package:androidproject/views/shared_widgets/navigation_bar.dart';

class ProfileView extends StatelessWidget {
  final String email;
  final TextEditingController portfolioNameController = TextEditingController();

  final stateController = getIt.get<ProfileController>();

  ProfileView({Key? key, required this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColors.indicatorColor,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Email',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              decoration: BoxDecoration(
                color: AppColors.indicatorColor,
                borderRadius: BorderRadius.circular(0),
              ),
              child: Text(
                email,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              'Create New Portfolio',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: portfolioNameController,
              cursorColor: Colors.white,
              decoration: InputDecoration(
                hintText: 'Portfolio Name',
                hintStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(0),
                  borderSide: const BorderSide(color: AppColors.indicatorColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(0),
                  borderSide: const BorderSide(color: AppColors.indicatorColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(0),
                  borderSide: const BorderSide(color: AppColors.indicatorColor),
                ),
                filled: true,
                fillColor: AppColors.indicatorColor,
              ),
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  final portfolioName = portfolioNameController.text;
                  if (portfolioName.isNotEmpty) {
                    stateController.createPortfolio(portfolioName).then((_) {
                      Navigator.pushReplacementNamed(context, '/dashboard');
                    }).catchError((error) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Failed to create portfolio: $error')),
                      );
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  foregroundColor: Colors.white,
                  backgroundColor: AppColors.indicatorColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                ),
                child: const Text(
                  'Create Portfolio',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomNavigationBar(),
    );
  }
}
