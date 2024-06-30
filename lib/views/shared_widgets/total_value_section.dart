import 'package:flutter/material.dart';
import 'package:androidproject/utils/app_theme.dart';

/// A widget that displays the total value of a portfolio or asset, indicating if the value is positive or negative.
class TotalValueSection extends StatelessWidget {
  // The total value to be displayed.
  final String totalValue;
  // Indicates if the total value is positive or negative.
  final bool isPositive;

  /// Constructs a TotalValueSection widget.
  ///
  /// The [totalValue] is the string representation of the total value.
  /// The [isPositive] indicates whether the value is positive or negative.
  const TotalValueSection({super.key, required this.totalValue, required this.isPositive});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10), // Adds vertical space.
        Row(
          mainAxisAlignment: MainAxisAlignment.center, // Centers the row contents horizontally.
          children: [
            // Icon indicating positive or negative trend.
            Icon(
              isPositive ? Icons.trending_up : Icons.trending_down,
              color: isPositive ? AppColors.positiveColor : AppColors.negativeColor,
              size: 24, // Icon size.
            ),
            const SizedBox(width: 8), // Adds horizontal space between icon and text.
            // Text displaying the total value.
            Text(
              totalValue,
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: isPositive ? AppColors.positiveColor : AppColors.negativeColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10), // Adds vertical space.
      ],
    );
  }
}
