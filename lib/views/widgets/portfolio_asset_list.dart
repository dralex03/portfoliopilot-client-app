import 'package:flutter/material.dart';
import 'package:androidproject/models/asset_item.dart';
import 'asset_widget/asset_list.dart';

/// A widget that displays a list of assets in a portfolio.
class PortfolioAssetList extends StatelessWidget {
  // The name of the selected portfolio.
  final String selectedPortfolio;
  // Callback function to handle when an asset is selected.
  final Function(AssetItem) onAssetSelected;

  /// Constructs a PortfolioAssetList widget.
  ///
  /// The [selectedPortfolio] is the name of the currently selected portfolio.
  /// The [onAssetSelected] is the callback function to handle asset selection.
  const PortfolioAssetList({super.key, required this.selectedPortfolio, required this.onAssetSelected});

  /// Retrieves the list of assets based on the selected portfolio.
  List<AssetItem> get assets {
    if (selectedPortfolio == 'Second Portfolio') {
      return [
        const AssetItem(
          title: 'Tesla',
          amount: '1800€ (+300€)',
          quantity: '3 Stück',
          currentPrice: '600€',
          purchasePrice: '500€',
          isPositive: true,
        ),
        const AssetItem(
          title: 'EA Sports',
          amount: '500€ (-50€)',
          quantity: '10 Stück',
          currentPrice: '50€',
          purchasePrice: '55€',
          isPositive: false,
        ),
      ];
    }
    return [
      const AssetItem(
        title: 'ISHARES S&P 500',
        amount: '500€ (+50€)',
        quantity: '5 Stück',
        currentPrice: '100€',
        purchasePrice: '90€',
        isPositive: true,
      ),
      const AssetItem(
        title: 'MSCI World',
        amount: '120€ (-10€)',
        quantity: '1 Stück',
        currentPrice: '120€',
        purchasePrice: '130€',
        isPositive: false,
      ),
      const AssetItem(
        title: 'Gold',
        amount: '100€ (+20€)',
        quantity: '2 Stück',
        currentPrice: '50€',
        purchasePrice: '40€',
        isPositive: true,
      ),
      const AssetItem(
        title: 'Tesla',
        amount: '1800€ (+300€)',
        quantity: '3 Stück',
        currentPrice: '600€',
        purchasePrice: '500€',
        isPositive: true,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10), // Adds vertical space.
        // Text widget to display the title 'Assetliste'.
        Text(
          'Assetliste',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold, color: Colors.white),
        ),
        // AssetList widget to display the list of assets.
        AssetList(
          assets: assets,
          onAssetSelected: onAssetSelected,
        ),
      ],
    );
  }
}
