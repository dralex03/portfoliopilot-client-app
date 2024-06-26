import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:androidproject/utils/app_theme.dart';

class ChartSection extends StatelessWidget {
  final double height;
  final bool isPositive;

  const ChartSection({super.key, required this.height, required this.isPositive});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      color: Colors.transparent,
      child: Stack(
        children: [
          Center(
            child: LineChart(
              _buildLineChartData(),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildPeriodButton(context, '1T'),
                  _buildPeriodButton(context, '1W'),
                  _buildPeriodButton(context, '1M'),
                  _buildPeriodButton(context, '1Y'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPeriodButton(BuildContext context, String text) {
    return ElevatedButton(
      onPressed: () {
        // Implement the logic to change the chart period.
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.backgroundColor,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
          side: const BorderSide(color: Colors.transparent),
        ),
        padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 4.0),
        minimumSize: const Size(0, 0),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 12),
      ),
    );
  }

  LineChartData _buildLineChartData() {
    return LineChartData(
      gridData: FlGridData(show: true),
      titlesData: FlTitlesData(
        leftTitles: SideTitles(
          showTitles: true,
          margin: 8,
        ),
        bottomTitles: SideTitles(
          showTitles: true,
          margin: 8,
        ),
      ),
      borderData: FlBorderData(show: true, border: Border.all(color: Colors.white, width: 1)),
      minX: 0,
      maxX: 11,
      minY: 125,
      maxY: 250,
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(0, 175),
            FlSpot(1, 180),
            FlSpot(2, 160),
            FlSpot(3, 170),
            FlSpot(4, 185),
            FlSpot(5, 190),
            FlSpot(6, 200),
            FlSpot(7, 220),
            FlSpot(8, 240),
            FlSpot(9, 230),
            FlSpot(10, 210),
            FlSpot(11, 150),
          ],
          isCurved: true,
          colors: [Colors.blue, Colors.green],
          barWidth: 3,
          isStrokeCapRound: true,
          dotData: FlDotData(show: false),
          belowBarData: BarAreaData(
            show: true,
            colors: [Colors.blue.withOpacity(0.5), Colors.green.withOpacity(0.5)],
          ),
        ),
      ],
    );
  }
}
