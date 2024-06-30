import 'package:flutter/material.dart';
import 'package:androidproject/utils/app_theme.dart';
import 'package:androidproject/views/shared_widgets/chart_section.dart';
import 'package:androidproject/views/asset/asset_widget/detailed_information_section.dart';
import 'package:androidproject/views/asset/add_asset_widget/asset_detail_view_add.dart';
import 'package:androidproject/views/asset/asset_widget/crypto_information_list.dart';
import 'dart:convert';
// import 'package:http/http.dart' as http;

class AssetDetailView extends StatefulWidget {
  final String title;
  final String currentPrice;
  final String quantity;
  final String purchasePrice;
  final bool isPositive;

  const AssetDetailView({
    super.key,
    required this.title,
    required this.currentPrice,
    required this.quantity,
    required this.purchasePrice,
    required this.isPositive,
  });

  @override
  _AssetDetailViewState createState() => _AssetDetailViewState();
}

class _AssetDetailViewState extends State<AssetDetailView> {
  Map<String, dynamic> cryptoData = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadTestData();
  }

  Future<void> loadTestData() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      cryptoData = {
        "name": "Bitcoin",
        "longName": "Bitcoin USD",
        "previousClose": 60888.445,
        "marketCap": 1216596672512,
        "circulatingSupply": 19718732,
        "volume24Hr": 13996477440,
        "dayHigh": 61706.465,
        "dayLow": 60646.215,
        "fiftyTwoWeekHigh": 73750.07,
        "fiftyTwoWeekLow": 24930.297,
        "fiftyDayAverage": 66376.88,
        "twoHundredDayAverage": 58015.203,
        "averageVolume10days": 22655481892,
        "regularMarketVolume": 13996477440,
        "description": "Bitcoin (BTC) is a cryptocurrency launched in 2010. Users are able to generate BTC through the process of mining. Bitcoin has a current supply of 19,718,650. The last known price of Bitcoin is 61,442.46555255 USD and is up 0.97 over the last 24 hours. It is currently trading on 11335 active market(s) with 13,321,545,748.80 traded over the last 24 hours. More information can be found at https://bitcoin.org/.",
      };
      isLoading = false;
    });
  }
  /*
  Future<void> fetchCryptoData() async {
  final url = 'https://example.com/api/crypto-data?title=${widget.title}'; // Beispielhafte API-URL
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
*/
  /*
  Future<void> fetchStockData() async {
    final url = 'https://example.com/api/stock-data?title=${widget.title}'; // Beispielhafte API-URL
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

  Future<void> fetchHoldings() async {
    final url = 'https://example.com/api/etf-data?title=${widget.title}';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        holdings = data['response']['etfData']['fund_holding_info']['holdings'];
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> fetchData() async {
    final url = 'https://example.com/api/crypto-data?title=${widget.title}';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        cryptoData = data['response'];
        isLoading = false;
      });
    } else {
      await loadTestData(); // Lade Testdaten im Fehlerfall
    }
  }
  */

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double chartHeight = screenHeight * 0.30;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          widget.title,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AssetDetailViewAdd(
                    title: widget.title,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: widget.isPositive
                  ? AppColors.positiveGradient
                  : AppColors.negativeGradient,
            ),
            child: Column(
              children: [
                const SizedBox(height: kToolbarHeight - 20),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Current Price: ${widget.currentPrice}',
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
                ChartSection(height: chartHeight, isPositive: widget.isPositive),
              ],
            ),
          ),
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                Container(
                  color: AppColors.indicatorColor,
                  child: const Center(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Buyer\'s Information',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                DetailedInformationSection(
                  quantity: widget.quantity,
                  purchasePrice: widget.purchasePrice,
                  isPositive: widget.isPositive,
                ),
                const SizedBox(height: 20),
                Container(
                  color: AppColors.indicatorColor,
                  child: const Center(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Asset Information',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                CryptoInformationList(
                  name: cryptoData['name'] ?? '',
                  longName: cryptoData['longName'] ?? '',
                  previousClose: cryptoData['previousClose'] ?? 0.0,
                  marketCap: cryptoData['marketCap'] ?? 0.0,
                  circulatingSupply: cryptoData['circulatingSupply'] ?? 0.0,
                  volume24Hr: cryptoData['volume24Hr'] ?? 0.0,
                  dayHigh: cryptoData['dayHigh'] ?? 0.0,
                  dayLow: cryptoData['dayLow'] ?? 0.0,
                  fiftyTwoWeekHigh: cryptoData['fiftyTwoWeekHigh'] ?? 0.0,
                  fiftyTwoWeekLow: cryptoData['fiftyTwoWeekLow'] ?? 0.0,
                  fiftyDayAverage: cryptoData['fiftyDayAverage'] ?? 0.0,
                  twoHundredDayAverage: cryptoData['twoHundredDayAverage'] ?? 0.0,
                  averageVolume10days: cryptoData['averageVolume10days'] ?? 0.0,
                  regularMarketVolume: cryptoData['regularMarketVolume'] ?? 0.0,
                  description: cryptoData['description'] ?? '',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
