import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: DropdownButton<String>(
        value: 'Main Portfolio',
        icon: Icon(Icons.arrow_downward, color: Colors.white),
        iconSize: 24,
        elevation: 16,
        style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: 'Lato'),
        underline: SizedBox(), // Entfernt die Unterstreichung
        onChanged: (String? newValue) {
          // Handle change
        },
        dropdownColor: Colors.black, // Hintergrundfarbe des Dropdown-Menüs
        items: <String>['Main Portfolio', 'Second Portfolio']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: TextStyle(color: Colors.white), // Textfarbe der Auswahl
            ),
          );
        }).toList(),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
