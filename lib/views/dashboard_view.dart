import 'package:androidproject/widgets/navigation_bar.dart';
import 'package:flutter/material.dart';
import '../app_theme.dart';
import '../widgets/asset_list.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/asset_item.dart';

class DashboardView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const double appBarHeight = kToolbarHeight; // Höhe der AppBar
    final double screenHeight = MediaQuery.of(context).size.height; // Gesamthöhe des Bildschirms
    final double chartHeight = screenHeight * 0.26; // 26% der Bildschirmhöhe für die Chart-Sektion

    // Beispiel-Assets
    final List<AssetItem> assets = [
      const AssetItem(title: 'ISHARES S&P 500', amount: '500€ (+50€)', quantity: '5', currentPrice: '100€', purchasePrice: '90€', isPositive: true),
      const AssetItem(title: 'MSCI World', amount: '120€ (-10€)', quantity: '1', currentPrice: '120€', purchasePrice: '130€', isPositive: false),
      const AssetItem(title: 'Gold', amount: '100€ (+20€)', quantity: '2', currentPrice: '50€', purchasePrice: '40€', isPositive: true),
      const AssetItem(title: 'Tesla', amount: '1800€ (+300€)', quantity: '3', currentPrice: '600€', purchasePrice: '500€', isPositive: true),
    ];

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: AppColors.neutralGradient,
            ),
            height: appBarHeight + chartHeight,
          ),
          Column(
            children: [
              // AppBar und Chart
              Container(
                decoration: const BoxDecoration(
                  gradient: AppColors.neutralGradient,
                ),
                child: Column(
                  children: [
                    CustomAppBar(), // AppBar einfügen
                    Container(
                      height: chartHeight, // Höhe der Chart-Sektion
                      color: Colors.transparent,
                      child: const Center(
                        child: Text('Chart Placeholder', style: TextStyle(color: Colors.white)),
                      ),
                    ),
                    Text(
                      '_totalValue€',
                      style: Theme.of(context).textTheme.displayMedium?.copyWith(color: Colors.white),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
              // Scrollbarer Bereich
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    color: AppColors.assetListColor, // Hintergrundfarbe des scrollbaren Bereichs
                    child: Column(
                      children: [
                        SizedBox(height: 10),
                        Text(
                          'Assetliste',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        // Asset list section
                        AssetList(assets: assets),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: CustomNavigationBar(),
    );
  }
}
