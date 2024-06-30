import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:androidproject/views/shared_widgets/navigation_bar.dart';
import 'package:androidproject/views/asset/asset_widget/asset_detail_app_bar.dart';
import 'package:androidproject/views/shared_widgets/chart_section.dart';
import 'package:androidproject/views/asset/asset_widget/detailed_information_section.dart';
import 'package:androidproject/views/asset/asset_widget/position_list.dart';
import 'package:androidproject/views/shared_widgets/total_value_section.dart';
import 'package:androidproject/utils/app_theme.dart';

/// A view that displays detailed information about an asset.
class AssetDetailView extends StatelessWidget {
  late String title;
  late double count;
  late double currentPrice;
  late double purchasePrice;
  late bool isPositive;
  late String totalOverview;

  /// Constructs an AssetDetailView.
  ///
  /// The [title] is the name of the asset.
  /// The [amount] is the total value of the asset.
  /// The [quantity] is the number of units owned.
  /// The [currentPrice] is the current price per unit.
  /// The [purchasePrice] is the price at which the asset was purchased.
  /// The [isPositive] indicates whether the asset value is positive or negative.

  AssetDetailView(this.title, this.count, this.currentPrice, this.purchasePrice, this.isPositive, {super.key}) {
    double diff = count * (currentPrice - purchasePrice);
    String sign = diff > 0 ? '+' : '';
    totalOverview = "${(count * currentPrice).toStringAsFixed(2)} ($sign${(diff).toStringAsFixed(2)})";
  }

  @override
  Widget build(BuildContext context) {


    final double screenHeight = MediaQuery.of(context).size.height;


    final double chartHeight = screenHeight * 0.30;

    return Scaffold(
      body: Column(
        children: [

          Container(
            decoration: BoxDecoration(
              gradient: isPositive
                  ? AppColors.positiveGradient
                  : AppColors.negativeGradient,
            ),
            child: Column(
              children: [

                AssetDetailAppBar(title: title),

                ChartSection(
                  height: chartHeight,
                  isPositive: isPositive,
                ),
              ],
            ),
          ),


          TotalValueSection(totalValue: totalOverview, isPositive: isPositive),

          const SizedBox(height: 10),


          Text(
            'Kauf-Informationen',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold, color: Colors.white),
          ),

          const SizedBox(height: 10),


          DetailedInformationSection(
            quantity: count.toString(),
            currentPrice: currentPrice.toStringAsFixed(2),
            purchasePrice: purchasePrice.toStringAsFixed(2),
            isPositive: isPositive,
          ),

          const SizedBox(height: 20),


          Text(
            'Positionen',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold, color: Colors.white),
          ),


          const Expanded(
            child: SingleChildScrollView(
              child: PositionList(),
            ),
          ),
        ],
      ),


      bottomNavigationBar: const CustomNavigationBar(),
    );
  }
}
