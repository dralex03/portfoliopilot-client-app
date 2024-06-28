import 'package:flutter/material.dart';

/// A widget that displays detailed information about an asset.
class DetailedInformationSection extends StatelessWidget {
  // The quantity of the asset.
  final String quantity;
  // The purchase price of the asset.
  final String purchasePrice;
  // Indicates if the asset value is positive or negative.
  final bool isPositive;

  /// Constructs a DetailedInformationSection widget.
  ///
  /// The [quantity] parameter specifies the quantity of the asset.
  /// The [purchasePrice] parameter specifies the purchase price of the asset.
  /// The [isPositive] parameter indicates whether the asset value is positive.
  const DetailedInformationSection({
    super.key,
    required this.quantity,
    required this.purchasePrice,
    required this.isPositive,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
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
