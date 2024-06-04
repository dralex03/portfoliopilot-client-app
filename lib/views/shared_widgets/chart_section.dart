import 'package:flutter/material.dart';
import 'package:androidproject/utils/app_theme.dart';

/// A widget that displays a chart section with period buttons.
class ChartSection extends StatelessWidget {
  // The height of the chart section.
  final double height;
  // Indicates if the chart is displaying positive data.
  final bool isPositive;

  /// Constructs a ChartSection widget.
  ///
  /// The [height] parameter specifies the height of the chart section.
  /// The [isPositive] parameter indicates whether the chart is showing positive data.
  const ChartSection({super.key, required this.height, required this.isPositive});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height, // Height of the chart section.
      color: Colors.transparent,
      child: Stack(
        children: [
          // Placeholder for the chart.
          const Center(
            child: Text('Chart Placeholder', style: TextStyle(color: Colors.white)),
          ),
          // Aligns the period buttons at the bottom center of the chart section.
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Period button for 1 day.
                  _buildPeriodButton(context, '1T'),
                  // Period button for 1 week.
                  _buildPeriodButton(context, '1W'),
                  // Period button for 1 month.
                  _buildPeriodButton(context, '1M'),
                  // Period button for 1 year.
                  _buildPeriodButton(context, '1Y'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Builds a button for selecting the chart period.
  ///
  /// The [context] parameter provides the build context.
  /// The [text] parameter specifies the label for the button.
  Widget _buildPeriodButton(BuildContext context, String text) {
    return ElevatedButton(
      onPressed: () {
        // Implement the logic to change the chart period.
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.backgroundColor, // Background color.
        foregroundColor: Colors.white, // Text color.
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0), // No border radius.
          side: const BorderSide(color: Colors.transparent), // No border side.
        ),
        padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 4.0), // Minimal padding.
        minimumSize: const Size(0, 0), // Minimum size to fit the text tightly.
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 12), // Small text size.
      ),
    );
  }
}
