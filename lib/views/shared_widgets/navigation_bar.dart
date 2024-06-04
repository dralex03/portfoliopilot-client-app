import 'package:flutter/material.dart';
import 'package:androidproject/utils/app_theme.dart';

/// A custom bottom navigation bar for the application.
class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: AppColors.navigationBarColor, // Background color of the navigation bar.
      selectedItemColor: AppColors.indicatorColor, // Color of the selected item.
      unselectedItemColor: Colors.white, // Color of the unselected items.
      items: const <BottomNavigationBarItem>[
        // Navigation bar item for home.
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        // Navigation bar item for adding new items.
        BottomNavigationBarItem(
          icon: Icon(Icons.add),
          label: 'Add',
        ),
        // Navigation bar item for charts.
        BottomNavigationBarItem(
          icon: Icon(Icons.show_chart),
          label: 'Charts',
        ),
      ],
    );
  }
}
