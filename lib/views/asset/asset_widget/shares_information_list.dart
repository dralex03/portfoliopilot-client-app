import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SharesInformationList extends StatefulWidget {
  final String title;

  const SharesInformationList({Key? key, required this.title}) : super(key: key);

  @override
  _SharesInformationListState createState() => _SharesInformationListState();
}

class _SharesInformationListState extends State<SharesInformationList> {
  Map<String, dynamic> stockData = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchStockData();
  }

  Future<void> fetchStockData() async {
    final url = 'https://example.com/api/stock-data?title=${widget.title}';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        stockData = data['response'];
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoRow('Name', stockData['longName']),
          _buildInfoRow('Industry', stockData['industry']),
          _buildInfoRow('Country', stockData['country']),
          _buildInfoRow('Forward P/E', stockData['forwardPE'].toString()),
          _buildInfoRow('Dividend Yield', '${(stockData['dividendYield'] * 100).toStringAsFixed(2)}%'),
          _buildInfoRow('Full Time Employees', stockData['fullTimeEmployees'].toString()),
          _buildInfoRow('Market Cap', _formatNumber(stockData['marketCap'])),
          _buildInfoRow('Revenue Per Share', '\$${stockData['revenuePerShare'].toString()}'),
          _buildInfoRow('Total Revenue', _formatNumber(stockData['totalRevenue'])),
          _buildInfoRow('Total Cash', _formatNumber(stockData['totalCash'])),
          _buildInfoRow('Total Debt', _formatNumber(stockData['totalDebt'])),
          _buildInfoRow('Trailing EPS', stockData['trailingEps'].toString()),
          _buildInfoRow('Trailing P/E', stockData['trailingPE'].toString()),
          _buildInfoRow('Shares Outstanding', _formatNumber(stockData['sharesOutstanding'])),
          _buildInfoRow('Shares Short', _formatNumber(stockData['sharesShort'])),
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

  String _formatNumber(num number) {
    return number.toString().replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (match) => ',');
  }
}
