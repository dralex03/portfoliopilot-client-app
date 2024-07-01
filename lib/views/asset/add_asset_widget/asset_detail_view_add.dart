import 'package:androidproject/controller/add_controller.dart';
import 'package:androidproject/services/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:androidproject/utils/app_theme.dart';
import 'package:androidproject/views/shared_widgets/chart_section.dart';
import 'package:androidproject/views/asset/add_asset_widget/editable_buy_information_widget.dart';
import 'package:androidproject/views/asset/asset_widget/etf_position_list.dart';
import 'package:androidproject/views/asset/asset_widget/crypto_information_list.dart';
import 'package:androidproject/views/asset/asset_widget/shares_information_list.dart';

class AssetDetailViewAdd extends StatefulWidget {
  final String title;
  final String ticker;
  final String assetType;

  const AssetDetailViewAdd({
    super.key,
    required this.title,
    required this.ticker,
    required this.assetType,
  });

  @override
  _AssetDetailViewAddState createState() => _AssetDetailViewAddState();
}

class _AssetDetailViewAddState extends State<AssetDetailViewAdd> {
  final AddController stateController = getIt<AddController>();

  final TextEditingController quantityController = TextEditingController();
  final TextEditingController orderFeeController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  bool isPositive = true;

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double chartHeight = screenHeight * 0.30;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColors.backgroundColor,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
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
                  orderFeeController: orderFeeController,
                  priceController: priceController,
                  isPositive: isPositive,
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
      bottomNavigationBar: BottomAppBar(
        color: AppColors.navigationBarColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: ElevatedButton(
            onPressed: () async {
              double quantity = double.parse(quantityController.text);
              double orderFee = double.parse(orderFeeController.text);
              double price = double.parse(priceController.text);
              stateController.addAsset(widget.ticker, quantity, orderFee, price);
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: AppColors.indicatorColor,
              backgroundColor: Colors.white,
            ).copyWith(
              overlayColor: WidgetStateProperty.resolveWith<Color?>(
                    (Set<WidgetState> states) {
                  if (states.contains(WidgetState.hovered)) {
                    return AppColors.indicatorColor.withOpacity(0.04);
                  }
                  if (states.contains(WidgetState.focused) || states.contains(WidgetState.pressed)) {
                    return AppColors.indicatorColor.withOpacity(0.12);
                  }
                  return null;
                },
              ),
            ),
            child: const Text('Add to Current Portfolio'),
          ),
        ),
      ),
    );
  }
}
