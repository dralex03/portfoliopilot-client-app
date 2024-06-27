import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:androidproject/controller/chart_controller.dart';
import 'package:androidproject/utils/app_theme.dart';

class ChartSection extends StatefulWidget {
  final double height;
  final bool isPositive;

  ChartSection({super.key, required this.height, required this.isPositive});

  @override
  _ChartSectionState createState() => _ChartSectionState();
}

class _ChartSectionState extends State<ChartSection> {
  final ChartController chartController = ChartController();
  String selectedPeriod = '1T';
  Future<List<FlSpot>>? chartData;

  @override
  void initState() {
    super.initState();
    chartData = chartController.getChartData(selectedPeriod);
  }

  void _updatePeriod(String period) {
    setState(() {
      selectedPeriod = period;
      chartData = chartController.getChartData(selectedPeriod);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: double.infinity,
      color: Colors.transparent,
      child: FutureBuilder<List<FlSpot>>(
        future: chartData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}', style: TextStyle(color: Colors.red)));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No data available', style: TextStyle(color: Colors.white)));
          } else {
            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 40.0, left: 10.0, right: 20.0),
                  child: LineChart(
                    _buildLineChartData(snapshot.data!),
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
            );
          }
        },
      ),
    );
  }

  Widget _buildPeriodButton(BuildContext context, String text) {
    return ElevatedButton(
      onPressed: () {
        _updatePeriod(text);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: selectedPeriod == text ? AppColors.indicatorColor : AppColors.backgroundColor,
        foregroundColor: selectedPeriod == text ? Colors.white : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
          side: BorderSide(
            color: selectedPeriod == text ? AppColors.indicatorColor : Colors.transparent,
            width: 2.0,
          ),
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

  LineChartData _buildLineChartData(List<FlSpot> spots) {
    double yInterval;
    double minY = spots.map((spot) => spot.y).reduce((a, b) => a < b ? a : b);
    double maxY = spots.map((spot) => spot.y).reduce((a, b) => a > b ? a : b);
    double range = maxY - minY;

    if (range > 100) {
      yInterval = 10;
    } else if (range > 20) {
      yInterval = 5;
    } else {
      yInterval = 2.5;
    }

    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        drawHorizontalLine: true,
        horizontalInterval: yInterval,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: Colors.white.withOpacity(0.1),
            strokeWidth: 1,
            dashArray: [5, 5],
          );
        },
      ),
      titlesData: FlTitlesData(
        leftTitles: SideTitles(
          showTitles: true,
          interval: yInterval,
          getTextStyles: (context) => const TextStyle(
                  color: Colors.white,
          ),
          margin: 8,
          reservedSize: 40,
        ),
        bottomTitles: SideTitles(
          showTitles: false,
        ),
      ),
      borderData: FlBorderData(show: false),
      minX: spots.first.x,
      maxX: spots.last.x,
      minY: minY,
      maxY: maxY,
      lineBarsData: [
        LineChartBarData(
          spots: spots,
          isCurved: false,
          colors: [AppColors.positiveColor],
          barWidth: 3,
          isStrokeCapRound: true,
          dotData: FlDotData(show: false),
          belowBarData: BarAreaData(
            show: true,
            colors: [Colors.transparent],
          ),
        ),
      ],
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.transparent,
          getTooltipItems: (touchedSpots) {
            return touchedSpots.map((touchedSpot) {
              return LineTooltipItem(
                touchedSpot.y.toStringAsFixed(0),
                const TextStyle(
                  color: Colors.white,
                ),
              );
            }).toList();
          },
        ),
      ),
    );
  }
}
