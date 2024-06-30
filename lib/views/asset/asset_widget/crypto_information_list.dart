import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CryptoInformationList extends StatelessWidget {
  final String name;
  final String longName;
  final double previousClose;
  final double marketCap;
  final int circulatingSupply;
  final double volume24Hr;
  final double dayHigh;
  final double dayLow;
  final double fiftyTwoWeekHigh;
  final double fiftyTwoWeekLow;
  final double fiftyDayAverage;
  final double twoHundredDayAverage;
  final int averageVolume10days;
  final int regularMarketVolume;
  final String description;

  CryptoInformationList({
    required this.name,
    required this.longName,
    required this.previousClose,
    required this.marketCap,
    required this.circulatingSupply,
    required this.volume24Hr,
    required this.dayHigh,
    required this.dayLow,
    required this.fiftyTwoWeekHigh,
    required this.fiftyTwoWeekLow,
    required this.fiftyDayAverage,
    required this.twoHundredDayAverage,
    required this.averageVolume10days,
    required this.regularMarketVolume,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final NumberFormat numberFormat = NumberFormat('#,##0', 'en_US');

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoRow('Name', name),
          _buildInfoRow('Long Name', longName),
          _buildInfoRow('Current Price', '\$${previousClose.toStringAsFixed(2)}'),
          _buildInfoRow('Market Cap', '\$${numberFormat.format(marketCap)}'),
          _buildInfoRow('Circulating Supply', '${numberFormat.format(circulatingSupply)} BTC'),
          _buildInfoRow('24h Volume', '\$${numberFormat.format(volume24Hr)}'),
          _buildInfoRow('Day High', '\$${dayHigh.toStringAsFixed(2)}'),
          _buildInfoRow('Day Low', '\$${dayLow.toStringAsFixed(2)}'),
          _buildInfoRow('52 Week High', '\$${fiftyTwoWeekHigh.toStringAsFixed(2)}'),
          _buildInfoRow('52 Week Low', '\$${fiftyTwoWeekLow.toStringAsFixed(2)}'),
          _buildInfoRow('50 Day Average', '\$${fiftyDayAverage.toStringAsFixed(2)}'),
          _buildInfoRow('200 Day Average', '\$${twoHundredDayAverage.toStringAsFixed(2)}'),
          _buildInfoRow('10 Day Avg Volume', numberFormat.format(averageVolume10days)),
          _buildInfoRow('Market Volume', numberFormat.format(regularMarketVolume)),
          const SizedBox(height: 10),
          Text(
            'Description:',
            style: const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          Text(
            description,
            style: const TextStyle(fontSize: 16, color: Colors.white),
          ),
          const SizedBox(height: 10),
          TextButton(
            onPressed: () {
              // Open coinMarketCapLink in browser
            },
            child: const Text(
              'More Info on CoinMarketCap',
              style: TextStyle(fontSize: 16, color: Colors.blue),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 16, color: Colors.white),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 16, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
