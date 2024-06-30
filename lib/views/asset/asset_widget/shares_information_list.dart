import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SharesInformationList extends StatelessWidget {

  final String apiUrl = "";

  SharesInformationList({Key? key}) : super(key: key);

  Future<Map<String, dynamic>> fetchShareInformation() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load share information');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: fetchShareInformation(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData) {
          return const Center(child: Text('No data available'));
        } else {
          final data = snapshot.data!;
          return Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Colors.transparent,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInfoRow('Name', data['name'] ?? 'N/A'),
                _buildInfoRow('Sector', data['sector'] ?? 'N/A'),
                _buildInfoRow('Book Value', data['bookValue']?.toString() ?? 'N/A'),
                _buildInfoRow('P/E Ratio', data['peRatio']?.toString() ?? 'N/A'),
                _buildInfoRow('Quantity', data['quantity']?.toString() ?? 'N/A'),
              ],
            ),
          );
        }
      },
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
