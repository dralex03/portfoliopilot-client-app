import 'package:flutter/material.dart';

/// A custom app bar for displaying asset details.
class AssetDetailAppBar extends StatelessWidget implements PreferredSizeWidget {

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
      backgroundColor: Colors.transparent,
      centerTitle: true,
      elevation: 0,
      iconTheme: const IconThemeData(color: Colors.white),
      actions: [
        IconButton(
          icon: const Icon(Icons.edit, color: Colors.white),
          onPressed: () {

          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
