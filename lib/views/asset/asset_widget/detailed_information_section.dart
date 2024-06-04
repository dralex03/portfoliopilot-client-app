import 'package:flutter/material.dart';
import 'package:androidproject/utils/app_theme.dart';

/// A widget that displays detailed information about an asset.
class DetailedInformationSection extends StatelessWidget {
  // The quantity of the asset.
  final String quantity;
  // The current price of the asset.
  final String currentPrice;
  // The purchase price of the asset.
  final String purchasePrice;
  // Indicates if the asset value is positive or negative.
  final bool isPositive;

  /// Constructs a DetailedInformationSection widget.
  ///
  /// The [quantity] parameter specifies the quantity of the asset.
  /// The [currentPrice] parameter specifies the current price of the asset.
  /// The [purchasePrice] parameter specifies the purchase price of the asset.
  /// The [isPositive] parameter indicates whether the asset value is positive.
  const DetailedInformationSection({
    super.key,
    required this.quantity,
    required this.currentPrice,
    required this.purchasePrice,
    required this.isPositive,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // Background color changes based on whether the asset value is positive or negative.
      decoration: BoxDecoration(
        color: isPositive ? AppColors.positiveColor : AppColors.negativeColor,
      ),
      padding: const EdgeInsets.all(10), // Padding inside the container.
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Distributes the children evenly along the main axis.
        children: [
          // Column for displaying the quantity of the asset.
          Column(
            children: [
              Text(
                quantity,
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
              const Text(
                'Stück',
                style: TextStyle(fontSize: 12, color: Colors.white),
              ),
            ],
          ),
          // Column for displaying the current price of the asset.
          Column(
            children: [
              Text(
                currentPrice,
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
              const Text(
                'aktueller Kurs',
                style: TextStyle(fontSize: 12, color: Colors.white),
              ),
            ],
          ),
          // Column for displaying the purchase date of the asset.
          const Column(
            children: [
              Text(
                '10.01.21',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              Text(
                'Kaufdatum',
                style: TextStyle(fontSize: 12, color: Colors.white),
              ),
            ],
          ),
          // Column for displaying the purchase price of the asset.
          Column(
            children: [
              Text(
                purchasePrice,
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
              const Text(
                'Kaufkurs',
                style: TextStyle(fontSize: 12, color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
