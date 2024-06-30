import 'package:flutter/material.dart';


class ETFPositionList extends StatelessWidget {
  final List<dynamic> holdings;

  const ETFPositionList({Key? key, required this.holdings}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: holdings.map((holding) {
          return _buildHoldingRow(
            holding['holdingName'],
            (holding['holdingPercent'] * 100).toStringAsFixed(2) + '%',
          );
        }).toList(),
      ),
    );
  }

  Widget _buildHoldingRow(String name, String percentage) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name,
            style: const TextStyle(fontSize: 16, color: Colors.white),
          ),
          Text(
            percentage,
            style: const TextStyle(fontSize: 16, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
