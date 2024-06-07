import 'package:flutter/material.dart';
import 'package:androidproject/utils/app_theme.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: AppColors.navigationBarColor, // Hintergrundfarbe der Navigation Bar
      selectedItemColor: AppColors.indicatorColor, // Auswahlfarbe
      unselectedItemColor: Colors.white, // Farbe für nicht ausgewählte Items
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add),
          label: 'Add',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.show_chart),
          label: 'Charts',
        ),
      ],
      onTap: (index) {
        switch (index) {
          case 0:
            Navigator.pushNamed(context, '/dashboard');
            break;
          case 1:
            Navigator.pushNamed(context, '/add');
            break;
          case 2:
            Navigator.pushNamed(context, '/charts');
            break;
        }
      },
    );
  }
}
