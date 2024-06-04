import 'package:flutter/material.dart';
import 'package:androidproject/utils/app_theme.dart';
import 'package:androidproject/views/dashboard/dashboard_widget/dashboard_app_bar.dart';
import 'package:androidproject/views/shared_widgets/navigation_bar.dart';
import 'package:androidproject/views/shared_widgets/chart_section.dart';
import 'package:androidproject/views/shared_widgets/total_value_section.dart';
import 'package:androidproject/views/dashboard/dashboard_widget/portfolio_asset_list.dart';

/// The main view for the dashboard, displaying the user's portfolios and their details.
class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  _DashboardViewState createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  // The currently selected portfolio.
  String selectedPortfolio = 'Main Portfolio';

  // Determines if the total value is positive or negative based on the selected portfolio.
  bool get isTotalValuePositive {
    // Implement logic to determine if total value is positive or negative
    // For simplicity, assume it's based on the first asset
    if (selectedPortfolio == 'Second Portfolio') {
      return false; // This should be dynamically determined based on assets
    }
    return true; // This should be dynamically determined based on assets
  }


  // Handles changing the selected portfolio.
  void _onPortfolioChanged(String portfolio) {
    setState(() {
      selectedPortfolio = portfolio;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Get the total screen height.
    final double screenHeight = MediaQuery.of(context).size.height;

    // Allocate 30% of the screen height for the chart section.
    final double chartHeight = screenHeight * 0.3;

    return Scaffold(
      body: Column(
        children: [
          // Fixed section with gradient background.
          Container(
            decoration: const BoxDecoration(
              gradient: AppColors.neutralGradient,
            ),
            child: Column(
              children: [
                // Custom AppBar with a callback for changing the portfolio.
                CustomAppBar(onPortfolioChanged: _onPortfolioChanged),
                // Section displaying a chart.
                ChartSection(
                  height: chartHeight,
                  isPositive: true, // Adjust based on your logic
                ),

                // Section displaying the total value of the portfolio.
                TotalValueSection(
                  totalValue: '_totalValue€',
                  isPositive: isTotalValuePositive,
                ),
              ],
            ),
          ),

          // Scrollable section with a list of portfolio assets.
          Expanded(
            child: Container(
              color: AppColors.assetListColor,
              child: SingleChildScrollView(
                child: PortfolioAssetList(
                  selectedPortfolio: selectedPortfolio,
                  onAssetSelected: (asset) {
                    // Handle asset selection, if needed
                  },
                ),
              ),
            ),
          ),
        ],
      ),

      // Custom navigation bar at the bottom.
      bottomNavigationBar: const CustomNavigationBar(),
    );
  }
}
