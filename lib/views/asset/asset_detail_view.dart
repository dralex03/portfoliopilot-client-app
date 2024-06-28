import 'package:flutter/material.dart';
import 'package:androidproject/utils/app_theme.dart';
import 'package:androidproject/views/shared_widgets/chart_section.dart';
import 'package:androidproject/views/asset/asset_widget/position_list.dart';
import 'package:androidproject/views/asset/asset_widget/detailed_information_section.dart';
import 'package:androidproject/views/asset/add_asset_widget/asset_detail_view_add.dart';


class AssetDetailView extends StatefulWidget {
  final String title;
  final String currentPrice; // Neuer Parameter für den aktuellen Kurs
  final String quantity; // Neuer Parameter für die Menge
  final String purchasePrice; // Neuer Parameter für den Kaufpreis
  final bool isPositive; // Neuer Parameter für den positiven Wert

  const AssetDetailView({
    super.key,
    required this.title,
    required this.currentPrice,
    required this.quantity,
    required this.purchasePrice,
    required this.isPositive,
    required String amount,
  });

  @override
  _AssetDetailViewState createState() => _AssetDetailViewState();
}

class _AssetDetailViewState extends State<AssetDetailView> {
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double chartHeight = screenHeight * 0.30;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          widget.title,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AssetDetailViewAdd(
                    title: widget.title,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: widget.isPositive
                  ? AppColors.positiveGradient
                  : AppColors.negativeGradient,
            ),
            child: Column(
              children: [
                const SizedBox(height: kToolbarHeight - 20), // Platz für die AppBar
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Current Price: ${widget.currentPrice}',
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
                ChartSection(height: chartHeight, isPositive: widget.isPositive),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                DetailedInformationSection(
                  quantity: widget.quantity,
                  purchasePrice: widget.purchasePrice,
                  isPositive: widget.isPositive,
                ),
                const SizedBox(height: 20),
                Text(
                  'Positions',
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
    );
  }
}
