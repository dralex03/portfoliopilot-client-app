import 'package:flutter/material.dart';
import 'package:androidproject/utils/app_theme.dart';
import 'package:flutter/services.dart'; // Für die Eingabeformatierer

class EditableBuyInformationSection extends StatelessWidget {
  final TextEditingController quantityController;
  final TextEditingController orderFeeController;
  final TextEditingController priceController;
  final bool isPositive;

  EditableBuyInformationSection({
    required this.quantityController,
    required this.orderFeeController,
    required this.priceController,
    required this.isPositive,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: quantityController,
                decoration: const InputDecoration(
                  labelText: 'Quantity',
                  labelStyle: TextStyle(color: Colors.white),
                  filled: true,
                  fillColor: AppColors.indicatorColor,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.indicatorColor),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.indicatorColor),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Colors.white),
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                cursorColor: Colors.white,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                controller: priceController,
                decoration: const InputDecoration(
                  labelText: 'Purchase Price',
                  labelStyle: TextStyle(color: Colors.white),
                  filled: true,
                  fillColor: AppColors.indicatorColor,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.indicatorColor),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.indicatorColor),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                style: const TextStyle(color: Colors.white),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                ],
                cursorColor: Colors.white,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        TextField(
          controller: orderFeeController,
          decoration: const InputDecoration(
            labelText: 'Order Fee',
            labelStyle: TextStyle(color: Colors.white),
            filled: true,
            fillColor: AppColors.indicatorColor,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.indicatorColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.indicatorColor),
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always,
          ),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          style: const TextStyle(color: Colors.white),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
          ],
          cursorColor: Colors.white,
        ),
      ],
    );
  }
}
