import 'package:flutter/material.dart';

/// A widget that displays a list of positions in a portfolio.
class PositionList extends StatelessWidget {
  const PositionList({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SizedBox(height: 10), // Adds vertical space at the top.
        // ListTile widget representing a position in the portfolio.
        ListTile(
          title: Text('Microsoft Corp', style: TextStyle(color: Colors.white)),
          trailing: Text('6,97%', style: TextStyle(color: Colors.white)),
        ),
        // ListTile widget representing another position in the portfolio.
        ListTile(
          title: Text('Apple Inc', style: TextStyle(color: Colors.white)),
          trailing: Text('6,07%', style: TextStyle(color: Colors.white)),
        ),
        // ListTile widget representing another position in the portfolio.
        ListTile(
          title: Text('Nvidia Corp', style: TextStyle(color: Colors.white)),
          trailing: Text('5,13%', style: TextStyle(color: Colors.white)),
        ),
        // Placeholder ListTile for additional positions.
        ListTile(
          title: Text('...', style: TextStyle(color: Colors.white)),
          trailing: Text('...%', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}
