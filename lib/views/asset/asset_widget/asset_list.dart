
import 'package:flutter/material.dart';
import 'package:androidproject/models/asset_item.dart';

/// A widget that displays a list of asset items.
class AssetList extends StatelessWidget {
  // The list of assets to be displayed.
  final List<AssetItem> assets;

  /// Constructs an AssetList widget.
  ///
  /// The [assets] parameter is the list of assets to display.
  /// The [onAssetSelected] parameter is the callback function when an asset is selected (currently not used).
  const AssetList({super.key, required this.assets, required Function(AssetItem) onAssetSelected});

  @override
  Widget build(BuildContext context) {

    return Column(
      // Maps each asset to an AssetItem widget and returns a list of these widgets.
      children: assets.map((asset) {
        return AssetItem(
          title: asset.title,
          amount: asset.amount,
          quantity: asset.quantity,
          currentPrice: asset.currentPrice,
          purchasePrice: asset.purchasePrice,
          isPositive: asset.isPositive,
        );
      }).toList(),
    );
  }
}
