import 'package:androidproject/views/asset/add_asset_widget/editable_buy_information_widget.dart';
import 'package:androidproject/views/asset/asset_widget/position_list.dart';
import 'package:flutter/material.dart';
import 'package:androidproject/utils/app_theme.dart';
import 'package:androidproject/views/shared_widgets/chart_section.dart';

class AssetDetailViewAdd extends StatefulWidget {
  final String title;

  const AssetDetailViewAdd({super.key, required this.title});

  @override
  _AssetDetailViewAddState createState() => _AssetDetailViewAddState();
}

class _AssetDetailViewAddState extends State<AssetDetailViewAdd> {
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  bool isPositive = true;

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double chartHeight = screenHeight * 0.30;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColors.backgroundColor,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white), // Set the back button color to white
      ),
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
                ChartSection(height: chartHeight, isPositive: isPositive),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                EditableBuyInformationSection(
                  quantityController: quantityController,
                  dateController: dateController,
                  isPositive: isPositive,
                ),
                const SizedBox(height: 20),
                Text(
                  'Positionen',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: 10),
                const PositionList(),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: AppColors.navigationBarColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: ElevatedButton(
            onPressed: () {
              // Handle the asset addition logic here
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: AppColors.indicatorColor,
              backgroundColor: Colors.white,
            ),
            child: const Text('Add to Current Portfolio'),
          ),
        ),
      ),
    );
  }
}
