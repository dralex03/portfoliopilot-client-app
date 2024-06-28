import 'package:androidproject/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Für die Eingabeformatierer

class EditableBuyInformationSection extends StatelessWidget {
  final TextEditingController quantityController;
  final TextEditingController dateController;
  final TextEditingController priceController; // Controller für den Kaufkurs
  final bool isPositive;
  final VoidCallback onDateTap; // Callback für den DatePicker

  EditableBuyInformationSection({
    required this.quantityController,
    required this.dateController,
    required this.priceController,
    required this.isPositive,
    required this.onDateTap,
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
                  labelStyle: TextStyle(color: Colors.white), // Textfarbe des Platzhalters
                  filled: true,
                  fillColor: AppColors.indicatorColor, // Hintergrundfarbe des Eingabefeldes
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.indicatorColor), // Rahmenfarbe wenn fokussiert
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.indicatorColor), // Rahmenfarbe wenn nicht fokussiert
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.always, // Label immer oben anzeigen
                ),
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Colors.white), // Textfarbe des eingegebenen Textes
                inputFormatters: [FilteringTextInputFormatter.digitsOnly], // Nur Zahlen erlauben
                cursorColor: Colors.white, // Cursorfarbe
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                controller: priceController,
                decoration: const InputDecoration(
                  labelText: 'Purchase Price',
                  labelStyle: TextStyle(color: Colors.white), // Textfarbe des Platzhalters
                  filled: true,
                  fillColor: AppColors.indicatorColor, // Hintergrundfarbe des Eingabefeldes
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.indicatorColor), // Rahmenfarbe wenn fokussiert
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.indicatorColor), // Rahmenfarbe wenn nicht fokussiert
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.always, // Label immer oben anzeigen
                ),
                keyboardType: const TextInputType.numberWithOptions(decimal: true), // Nur Zahlen erlauben
                style: const TextStyle(color: Colors.white), // Textfarbe des eingegebenen Textes
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')), // Nur Zahlen und maximal zwei Dezimalstellen erlauben
                ],
                cursorColor: Colors.white, // Cursorfarbe
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        TextField(
          controller: dateController,
          decoration: const InputDecoration(
            labelText: 'Date',
            labelStyle: TextStyle(color: Colors.white), // Textfarbe des Platzhalters
            filled: true,
            fillColor: AppColors.indicatorColor, // Hintergrundfarbe des Eingabefeldes
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.indicatorColor), // Rahmenfarbe wenn fokussiert
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.indicatorColor), // Rahmenfarbe wenn nicht fokussiert
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always, // Label immer oben anzeigen
          ),
          readOnly: true,
          onTap: onDateTap, // Datumsauswahl öffnen
          style: const TextStyle(color: Colors.white), // Textfarbe des eingegebenen Textes
          cursorColor: Colors.white, // Cursorfarbe
        ),
      ],
    );
  }
}
