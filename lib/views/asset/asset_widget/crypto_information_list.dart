import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CryptoInformationList extends StatefulWidget {
  final String title;

  const CryptoInformationList({Key? key, required this.title}) : super(key: key);

  @override
  _CryptoInformationListState createState() => _CryptoInformationListState();
}

class _CryptoInformationListState extends State<CryptoInformationList> {
  Map<String, dynamic> cryptoData = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    fetchCryptoData();
  }

  Future<void> fetchCryptoData() async {
    final url = 'https://example.com/api/crypto-data?title=${widget.title}';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        cryptoData = data['response'];
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
          _buildInfoRow('Name', cryptoData['name']),
          _buildInfoRow('Long Name', cryptoData['longName']),
          _buildInfoRow('Previous Close', cryptoData['previousClose'].toString()),
          _buildInfoRow('Market Cap', _formatNumber(cryptoData['marketCap'])),
          _buildInfoRow('Circulating Supply', _formatNumber(cryptoData['circulatingSupply'])),
          _buildInfoRow('Volume 24Hr', _formatNumber(cryptoData['volume24Hr'])),
          _buildInfoRow('Day High', cryptoData['dayHigh'].toString()),
          _buildInfoRow('Day Low', cryptoData['dayLow'].toString()),
          _buildInfoRow('52 Week High', cryptoData['fiftyTwoWeekHigh'].toString()),
          _buildInfoRow('52 Week Low', cryptoData['fiftyTwoWeekLow'].toString()),
          _buildInfoRow('50 Day Average', cryptoData['fiftyDayAverage'].toString()),
          _buildInfoRow('200 Day Average', cryptoData['twoHundredDayAverage'].toString()),
          _buildInfoRow('Average Volume 10 Days', _formatNumber(cryptoData['averageVolume10days'])),
          _buildInfoRow('Regular Market Volume', _formatNumber(cryptoData['regularMarketVolume'])),
          _buildInfoRow('Description', cryptoData['description']),
          _buildInfoRow('CoinMarketCap Link', cryptoData['coinMarketCapLink']),
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
