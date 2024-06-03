import 'package:flutter/material.dart';
import 'asset_item.dart';

class AssetList extends StatelessWidget {
  final List<AssetItem> assets;

  const AssetList({required this.assets});

  @override
  Widget build(BuildContext context) {
    return Column(
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
