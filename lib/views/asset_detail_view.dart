import 'package:flutter/material.dart';
import 'package:androidproject/views/widgets/navigation_bar.dart';
import 'package:androidproject/views/widgets/asset_widget/asset_detail_app_bar.dart';
import 'package:androidproject/views/widgets/chart_section.dart';
import 'package:androidproject/views/widgets/asset_widget/detailed_information_section.dart';
import 'package:androidproject/views/widgets/position_list.dart';
import 'package:androidproject/views/widgets/total_value_section.dart';
import 'package:androidproject/utils/app_theme.dart';

/// A view that displays detailed information about an asset.
class AssetDetailView extends StatelessWidget {
  final String title;
  final String amount;
  final String quantity;
  final String currentPrice;
  final String purchasePrice;
  final bool isPositive;

  /// Constructs an AssetDetailView.
  ///
  /// The [title] is the name of the asset.
  /// The [amount] is the total value of the asset.
  /// The [quantity] is the number of units owned.
  /// The [currentPrice] is the current price per unit.
  /// The [purchasePrice] is the price at which the asset was purchased.
  /// The [isPositive] indicates whether the asset value is positive or negative.
  const AssetDetailView({
    super.key,
    required this.title,
    required this.amount,
    required this.quantity,
    required this.currentPrice,
    required this.purchasePrice,
    required this.isPositive,
  });

  @override
  Widget build(BuildContext context) {

    // Get the total screen height.
    final double screenHeight = MediaQuery.of(context).size.height;

    // Allocate 30% of the screen height for the chart section.
    final double chartHeight = screenHeight * 0.30;

    return Scaffold(
      body: Column(
        children: [
          // A Fixed gradient section based on the asset value.
          Container(
            decoration: BoxDecoration(
              gradient: isPositive
                  ? AppColors.positiveGradient
                  : AppColors.negativeGradient,
            ),
            child: Column(
              children: [
                // Custom AppBar for the asset detail view.
                AssetDetailAppBar(title: title),
                // Section displaying a chart related to the asset.
                ChartSection(
                  height: chartHeight,
                  isPositive: isPositive,
                ),
              ],
            ),
          ),

          // Section displaying the total value of the asset.
          TotalValueSection(totalValue: amount, isPositive: isPositive),

          const SizedBox(height: 10),

          // Text indicating purchase information.
          Text(
            'Kauf-Informationen',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold, color: Colors.white),
          ),

          const SizedBox(height: 10),

          // Section displaying detailed information about the asset.
          DetailedInformationSection(
            quantity: quantity,
            currentPrice: currentPrice,
            purchasePrice: purchasePrice,
            isPositive: isPositive,
          ),

          const SizedBox(height: 20),

          // Text indicating positions.
          Text(
            'Positionen',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold, color: Colors.white),
          ),

          // Scrollable list of positions related to the asset.
          const Expanded(
            child: SingleChildScrollView(
              child: PositionList(),
            ),
          ),
        ],
      ),

      // Custom navigation bar at the bottom.
      bottomNavigationBar: const CustomNavigationBar(),
    );
  }
}
