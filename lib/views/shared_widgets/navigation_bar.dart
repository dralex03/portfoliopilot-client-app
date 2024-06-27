import 'package:flutter/material.dart';
import 'package:androidproject/utils/app_theme.dart';

class CustomNavigationBar extends StatefulWidget {
  final int currentIndex;
  const CustomNavigationBar({super.key, this.currentIndex = 0});

  @override
  _CustomNavigationBarState createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.currentIndex;
  }

  void _onItemTapped(int index) {
    if (_currentIndex != index) {
      setState(() {
        _currentIndex = index;
      });
      switch (index) {
        case 0:
          Navigator.pushReplacementNamed(context, '/dashboard');
          break;
        case 1:
          Navigator.pushReplacementNamed(context, '/add');
          break;
        case 2:
          Navigator.pushReplacementNamed(context, '/charts');
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: AppColors.navigationBarColor, // Hintergrundfarbe der Navigation Bar
      selectedItemColor: Colors.grey, // Auswahlfarbe
      unselectedItemColor: Colors.white, // Farbe für nicht ausgewählte Items
      currentIndex: _currentIndex, // Set the current index
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
      onTap: _onItemTapped, // Handle item tap
    );
  }
}
