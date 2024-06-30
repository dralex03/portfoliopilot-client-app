import 'package:flutter/material.dart';
import 'package:androidproject/utils/app_theme.dart';
import 'package:androidproject/views/shared_widgets/chart_section.dart';
import 'package:androidproject/views/asset/add_asset_widget/editable_buy_information_widget.dart';
import 'package:androidproject/views/asset/asset_widget/position_list.dart';
import 'package:intl/intl.dart';

class AssetDetailViewAdd extends StatefulWidget {
  final String title;

  const AssetDetailViewAdd({
    super.key,
    required this.title,
  });

  @override
  _AssetDetailViewAddState createState() => _AssetDetailViewAddState();
}

class _AssetDetailViewAddState extends State<AssetDetailViewAdd> {
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  bool isPositive = true;

  Future<void> _saveData() async {
    String quantity = quantityController.text;
    String date = dateController.text;
    String price = priceController.text;


    print('Saved Data: Quantity: $quantity, Date: $date, Price: $price');
  }

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
                  priceController: priceController,
                  isPositive: isPositive,
                  onDateTap: _selectDate,
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
            onPressed: () async {
              await _saveData();
              // Optional: Navigate back or show a success message
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
                  return null; // Defer to the widget's default.
                },
              ),
            ),
            child: const Text('Add to Current Portfolio'),
          ),
        ),
      ),
    );
  }

  // Methode zur Auswahl eines Datums
  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.indicatorColor, // Header background color
              onPrimary: Colors.white, // Header text color
              onSurface: Colors.black, // Body text color
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        dateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }
}
