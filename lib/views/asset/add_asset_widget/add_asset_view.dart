import 'package:androidproject/models/element.dart';
import 'package:androidproject/views/asset/add_asset_widget/asset_detail_view_add.dart';
import 'package:androidproject/views/shared_widgets/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:androidproject/utils/app_theme.dart';

import '../../../controller/add_controller.dart';
import '../../../services/service_locator.dart';

class AddAssetScreen extends StatefulWidget {
  const AddAssetScreen({super.key});

  @override
  _AddAssetScreenState createState() => _AddAssetScreenState();
}

class _AddAssetScreenState extends State<AddAssetScreen> {
  final stateController = getIt<AddController>();

  final TextEditingController searchController = TextEditingController();
  List<String> assets = [
    'ISHARES S&P 500',
    'TESLA INC',
    'APPLE INC',
  ]; // Example static list, you can replace this with dynamic data
  List<PortfolioElement> searchAssets = List.empty(growable: true);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Asset',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: AppColors.backgroundColor,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white), // Set the back button color to white
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/dashboard');
          },
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
              textInputAction: TextInputAction.search,
              controller: searchController,
              onFieldSubmitted: (value) async {
                var result = await stateController.searchAssets(value);
                setState(() {
                  searchAssets = result.data as List<PortfolioElement>;
                });
              },
              decoration: const InputDecoration(
                hintText: 'Suche nach ETFs, Aktien, Derivaten, ...',
                fillColor: AppColors.indicatorColor,
                filled: true,
                prefixIcon: Icon(Icons.search, color: Colors.white),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                contentPadding: EdgeInsets.all(16.0),
                hintStyle: TextStyle(color: Colors.grey),
              ),
              style: const TextStyle(color: Colors.white),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: searchAssets.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  decoration: const BoxDecoration(
                    color: AppColors.indicatorColor,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: ListTile(
                          title: Text(
                            searchAssets[index].asset.name,
                            style: const TextStyle(color: Colors.white),
                          )
                        ),
                      ),
                      SizedBox(
                        height: 60, // Adjust the height as needed
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AssetDetailViewAdd(
                                  title: searchAssets[index].asset.name,
                                  ticker: searchAssets[index].asset.tickerSymbol,
                                ),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white, // Button color from your example
                            backgroundColor: AppColors.assetListColor, // Text color from your example
                            padding: EdgeInsets.zero, // Remove all padding
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(0),
                                bottomRight: Radius.circular(0),
                              ), // No border radius for right side
                            ),
                          ),
                          child: const Icon(Icons.add),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: const CustomNavigationBar(currentIndex: 1),
      backgroundColor: AppColors.backgroundColor,
    );
  }
}
