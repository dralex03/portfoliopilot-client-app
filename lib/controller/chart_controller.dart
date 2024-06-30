import 'package:fl_chart/fl_chart.dart';
import 'dart:math';

class ChartController {
  // Method to gather chart data (currently test data)
  Future<List<FlSpot>> getChartData(String period) async {
    switch (period) {
      case '1T':
        return _generateRandomChartData(24); // 24 Stunden für einen Tag
      case '1W':
        return _generateRandomChartData(7); // 7 Tage für eine Woche
      case '1M':
        return _generateRandomChartData(30); // 30 Tage für einen Monat
      case '1Y':
        return _generateRandomChartData(12); // 12 Monate für ein Jahr
      default:
        return _generateRandomChartData(30); // Standardmäßig 30 Punkte
    }
  }

  List<FlSpot> _generateRandomChartData(int numberOfPoints) {
    List<FlSpot> points = [];
    Random random = Random();

    // Startpunkt
    double x = 0;
    double y = 100 + random.nextDouble() * 20; // Initialer Y-Wert um 100-120

    points.add(FlSpot(x, y));

    for (int i = 1; i < numberOfPoints; i++) {
      x = i.toDouble();
      // Zufällige Änderung am Y-Wert, um einen realistischen Verlauf zu simulieren
      y += (random.nextDouble() - 0.5) * 10; // Änderung zwischen -5 und +5

      // Sicherstellen, dass der Wert positiv bleibt und keine unrealistischen Sprünge macht
      if (y < 0) {
        y = 0;
      }

      points.add(FlSpot(x, y));
    }

    return points;
  }
}
