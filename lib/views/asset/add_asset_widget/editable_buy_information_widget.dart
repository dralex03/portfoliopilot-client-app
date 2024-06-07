import 'package:flutter/material.dart';
import 'package:androidproject/utils/app_theme.dart';

class EditableBuyInformationSection extends StatelessWidget {
  final TextEditingController quantityController;
  final TextEditingController dateController;
  final bool isPositive;

  const EditableBuyInformationSection({
    super.key,
    required this.quantityController,
    required this.dateController,
    required this.isPositive,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isPositive ? AppColors.positiveColor : AppColors.negativeColor,
      ),
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              SizedBox(
                width: 80,
                child: TextField(
                  controller: quantityController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: '0',
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                ),
              ),
              const Text('Anzahl', style: TextStyle(fontSize: 12, color: Colors.white)),
            ],
          ),
          const Column(
            children: [
              SizedBox(
                width: 80,
                child: Text(
                  '100€',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
              Text('aktueller Kurs', style: TextStyle(fontSize: 12, color: Colors.white)),
            ],
          ),
          Column(
            children: [
              SizedBox(
                width: 80,
                child: TextField(
                  controller: dateController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'DD.MM.YY',
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
              const Text('Kaufdatum', style: TextStyle(fontSize: 12, color: Colors.white)),
            ],
          ),
          const Column(
            children: [
              SizedBox(
                width: 80,
                child: Text(
                  '100€',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
              Text('Kaufkurs', style: TextStyle(fontSize: 12, color: Colors.white)),
            ],
          ),
        ],
      ),
    );
  }
}
