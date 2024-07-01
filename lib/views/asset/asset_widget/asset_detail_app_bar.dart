import 'package:flutter/material.dart';
import 'package:androidproject/views/asset/add_asset_widget/asset_detail_view_add.dart';

/// A custom app bar for displaying asset details.
class AssetDetailAppBar extends StatelessWidget implements PreferredSizeWidget {
  // The title to be displayed in the app bar.
  final String title;
  final String ticker;
  final String assetType;

  /// Constructs an AssetDetailAppBar widget.
  ///
  /// The [title] parameter specifies the title of the app bar.
  const AssetDetailAppBar({super.key, required this.ticker, required this.assetType, required this.title});

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
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AssetDetailViewAdd(
                  title: title,
                  ticker: ticker,
                  assetType: assetType
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
