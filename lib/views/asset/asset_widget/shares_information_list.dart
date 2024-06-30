import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SharesInformationList extends StatelessWidget {
  final double forwardPE;
  final String industry;
  final String country;
  final double dividendYield;
  final int fullTimeEmployees;
  final double marketCap;
  final String longName;
  final double revenuePerShare;
  final double totalRevenue;
  final double totalCash;
  final double totalDebt;
  final double trailingEps;
  final double trailingPE;
  final double sharesOutstanding;
  final double sharesShort;

  SharesInformationList({
    required this.forwardPE,
    required this.industry,
    required this.country,
    required this.dividendYield,
    required this.fullTimeEmployees,
    required this.marketCap,
    required this.longName,
    required this.revenuePerShare,
    required this.totalRevenue,
    required this.totalCash,
    required this.totalDebt,
    required this.trailingEps,
    required this.trailingPE,
    required this.sharesOutstanding,
    required this.sharesShort,
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
          _buildInfoRow('Name', longName),
          _buildInfoRow('Industry', industry),
          _buildInfoRow('Country', country),
          _buildInfoRow('Forward P/E', forwardPE.toStringAsFixed(2)),
          _buildInfoRow('Dividend Yield', '${(dividendYield).toStringAsFixed(2)}%'),
          _buildInfoRow('Full Time Employees', numberFormat.format(fullTimeEmployees)),
          _buildInfoRow('Market Cap', '\$${numberFormat.format(marketCap)}'),
          _buildInfoRow('Revenue Per Share', '\$${numberFormat.format(revenuePerShare)}'),
          _buildInfoRow('Total Revenue', '\$${numberFormat.format(totalRevenue)}'),
          _buildInfoRow('Total Cash', '\$${numberFormat.format(totalCash)}'),
          _buildInfoRow('Total Debt', '\$${numberFormat.format(totalDebt)}'),
          _buildInfoRow('Trailing EPS', trailingEps.toStringAsFixed(2)),
          _buildInfoRow('Trailing P/E', trailingPE.toStringAsFixed(2)),
          _buildInfoRow('Shares Outstanding', numberFormat.format(sharesOutstanding)),
          _buildInfoRow('Shares Short', numberFormat.format(sharesShort)),
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
