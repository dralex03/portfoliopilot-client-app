import 'package:flutter/material.dart';
import 'package:androidproject/utils/app_theme.dart';
import 'package:androidproject/views/shared_widgets/chart_section.dart';
import 'package:androidproject/views/asset/asset_widget/detailed_information_section.dart';
import 'package:androidproject/views/asset/add_asset_widget/asset_detail_view_add.dart';
import 'package:androidproject/views/asset/asset_widget/crypto_information_list.dart';
import 'dart:convert';

import 'asset_widget/etf_position_list.dart';
import 'asset_widget/shares_information_list.dart';
// import 'package:http/http.dart' as http;

class AssetDetailView extends StatefulWidget {
  final String assetType;
  final String title;
  final String currentPrice;
  final String quantity;
  final String purchasePrice;
  final bool isPositive;

  const AssetDetailView({
    super.key,
    required this.title,
    required this.assetType,
    required this.currentPrice,
    required this.quantity,
    required this.purchasePrice,
    required this.isPositive,
  });

  @override
  _AssetDetailViewState createState() => _AssetDetailViewState();
}

class _AssetDetailViewState extends State<AssetDetailView> {
  Map<String, dynamic> cryptoData = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
  }




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
                    assetType: widget.assetType,
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
                const SizedBox(height: kToolbarHeight - 20),
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
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                Container(
                  color: AppColors.indicatorColor,
                  child: const Center(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Buyer\'s Information',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                DetailedInformationSection(
                  quantity: widget.quantity,
                  purchasePrice: widget.purchasePrice,
                  isPositive: widget.isPositive,
                ),
                const SizedBox(height: 20),
                Container(
                  color: AppColors.indicatorColor,
                  child: const Center(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Asset Information',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                if (widget.assetType == 'Crypto')
                  CryptoInformationList(title: widget.title)
                else if (widget.assetType == 'ETF')
                  ETFPositionList(title: widget.title)
                else
                  SharesInformationList(title: widget.title),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
