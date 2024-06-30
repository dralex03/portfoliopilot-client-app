import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ETFPositionList extends StatefulWidget {
  final String title;

  const ETFPositionList({Key? key, required this.title}) : super(key: key);

  @override
  _ETFPositionListState createState() => _ETFPositionListState();
}

class _ETFPositionListState extends State<ETFPositionList> {
  List<dynamic> holdings = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchHoldings();
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

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: holdings.length,
      itemBuilder: (context, index) {
        final holding = holdings[index];
        return ListTile(
          title: Text(
            holding['holdingName'],
            style: const TextStyle(color: Colors.white),
          ),
          trailing: Text(
            '${(holding['holdingPercent'] * 100).toStringAsFixed(2)}%',
            style: const TextStyle(color: Colors.white),
          ),
        );
      },
    );
  }
}
