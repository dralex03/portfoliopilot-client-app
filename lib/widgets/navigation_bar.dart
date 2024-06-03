import 'package:flutter/material.dart';
import '../app_theme.dart';

import 'package:flutter/material.dart';
import '../app_theme.dart';

class CustomNavigationBar extends StatelessWidget {
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
        ),BottomNavigationBarItem(
          icon: Icon(Icons.add),
          label: 'add',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.show_chart),
          label: 'Charts',
        ),
      ],
    );
  }
}

