import 'package:androidproject/views/asset/add_asset_widget/asset_detail_view_add.dart';
import 'package:androidproject/views/shared_widgets/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:androidproject/utils/app_theme.dart';

class AddAssetScreen extends StatefulWidget {
  const AddAssetScreen({super.key});

  @override
  _AddAssetScreenState createState() => _AddAssetScreenState();
}

class _AddAssetScreenState extends State<AddAssetScreen> {
  final TextEditingController searchController = TextEditingController();
  List<String> assets = [
    'ISHARES S&P 500',
    'TESLA INC',
    'APPLE INC',
  ]; // Example static list, you can replace this with dynamic data
  List<String> filteredAssets = [];

  @override
  void initState() {
    super.initState();
    filteredAssets = assets;
  }

  void _filterAssets(String query) {
    final results = assets.where((asset) => asset.toLowerCase().contains(query.toLowerCase())).toList();
    setState(() {
      filteredAssets = results;
    });
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
          icon: Icon(Icons.arrow_back),
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
              controller: searchController,
              onChanged: _filterAssets,
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
              itemCount: filteredAssets.length,
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
                            filteredAssets[index],
                            style: const TextStyle(color: Colors.white),
                          ),
                          trailing: const Text(
                            '100€ (+10)',
                            style: TextStyle(color: AppColors.positiveColor),
                          ),
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
                                  title: filteredAssets[index],
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
