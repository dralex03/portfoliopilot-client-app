import 'dart:ffi';

import 'package:androidproject/utils/app_theme.dart';
import 'package:androidproject/views/asset/asset_detail_view.dart';
import 'package:flutter/material.dart';

class AssetItem extends StatelessWidget {
  late String assetType;
  late String ticker;
  late String title;
  late double count;
  late double currentPrice;
  late double purchasePrice;
  late bool isPositive;
  late String totalOverview;

  AssetItem(this.ticker, this.assetType, this.title, this.count, this.currentPrice, this.purchasePrice, this.isPositive, {super.key}) {
    double diff = count * (currentPrice - purchasePrice);
    String sign = diff > 0 ? '+' : '';
    totalOverview = "${(count * currentPrice).toStringAsFixed(2)} ($sign${(diff).toStringAsFixed(2)})";
  }

  @override
  Widget build(BuildContext context) {
    // Gradient Variable definieren
    LinearGradient gradient = LinearGradient(
      colors: isPositive
          ? [
        AppColors.positiveColor.withOpacity(0.1),
        AppColors.assetItemColor.withOpacity(0.7),
      ]
          : [
        AppColors.negativeColor.withOpacity(0.1),
        AppColors.assetItemColor.withOpacity(0.7),
      ],
      stops: const [0, 0.4], // Spezielle Stops für den Farbverlauf
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AssetDetailView(
              assetType: assetType,
              title: title,
              quantity: count.toString(),
              currentPrice: currentPrice.toStringAsFixed(2),
              isPositive: isPositive,
              purchasePrice: purchasePrice.toStringAsFixed(2),
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          gradient: gradient,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                Row(
                  children: [
                    Icon(isPositive ? Icons.arrow_upward : Icons.arrow_downward, color: isPositive ? AppColors.positiveColor : AppColors.negativeColor),
                    Text(totalOverview, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: isPositive ? AppColors.positiveColor : AppColors.negativeColor)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 5),
            const Divider(color: Colors.white),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(count.toString(), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.white)),
                    const Text('Stück', style: TextStyle(fontSize: 12, color: Colors.white)),
                  ],
                ),
                Column(
                  children: [
                    Text(currentPrice.toStringAsFixed(2), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                    const Text('aktueller Kurs', style: TextStyle(fontSize: 12, color: Colors.white)),
                  ],
                ),
                Column(
                  children: [
                    Text(purchasePrice.toStringAsFixed(2), style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold, color: Colors.white)),
                    const Text('Kaufkurs', style: TextStyle(fontSize: 12, color: Colors.white)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
