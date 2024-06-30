import 'package:androidproject/utils/app_theme.dart';
import 'package:androidproject/views/asset/asset_detail_view.dart';
import 'package:flutter/material.dart';

class AssetItem {
  final String title;
  final String amount;
  final String quantity;
  final String currentPrice;
  final String purchasePrice;
  final bool isPositive;


  const AssetItem({
    required this.title,
    required this.amount,
    required this.quantity,
    required this.currentPrice,
    required this.purchasePrice,
    required this.isPositive,
  });
}
