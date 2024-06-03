import 'package:flutter/material.dart';

/// A custom app bar for displaying asset details.
class AssetDetailAppBar extends StatelessWidget implements PreferredSizeWidget {
  // The title to be displayed in the app bar.
  final String title;

  /// Constructs an AssetDetailAppBar widget.
  ///
  /// The [title] parameter specifies the title of the app bar.
  const AssetDetailAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      backgroundColor: Colors.transparent, // Makes the app bar background transparent.
      centerTitle: true, // Centers the title.
      elevation: 0, // Removes the shadow.
      iconTheme: const IconThemeData(color: Colors.white), // Sets the color of the app bar icons.
      actions: [
        IconButton(
          icon: const Icon(Icons.edit, color: Colors.white),
          onPressed: () {
            // Implement the edit functionality
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight); // Sets the height of the app bar.
}