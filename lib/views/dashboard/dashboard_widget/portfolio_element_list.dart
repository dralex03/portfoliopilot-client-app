
import 'package:androidproject/models/element.dart';
import 'package:flutter/material.dart';

import 'asset_item.dart';

/// A widget that displays a list of asset items.
class PortfolioElementList extends StatelessWidget {
  // The list of assets to be displayed.
  final List<PortfolioElement> elements;

  /// Constructs an PortfolioElementList widget.
  ///
  /// The [assets] parameter is the list of assets to display.
  /// The [onAssetSelected] parameter is the callback function when an asset is selected (currently not used).
  const PortfolioElementList({super.key, required this.elements, required Function(AssetItem) onAssetSelected});

  @override
  Widget build(BuildContext context) {

    return Column(
      // Maps each asset to an AssetItem widget and returns a list of these widgets.
      children: elements.map((element) {
        return AssetItem(
          element.asset.tickerSymbol,
          element.asset.name,
          element.count,
          element.asset.currentPrice,
          element.buyPrice,
          element.isPositive(),
        );
      }).toList(),
    );
  }
}
