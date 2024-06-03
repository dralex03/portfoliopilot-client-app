import 'package:flutter/material.dart';
import '../app_theme.dart';
import '../widgets/navigation_bar.dart';

class AssetDetailView extends StatelessWidget {
  final String title;
  final String amount;
  final String quantity;
  final String currentPrice;
  final String purchasePrice;
  final bool isPositive;

  const AssetDetailView({
    required this.title,
    required this.amount,
    required this.quantity,
    required this.currentPrice,
    required this.purchasePrice,
    required this.isPositive,
  });

  @override
  Widget build(BuildContext context) {
    final double appBarHeight = kToolbarHeight; // Höhe der AppBar
    final double screenHeight = MediaQuery.of(context).size.height; // Gesamthöhe des Bildschirms
    final double chartHeight = screenHeight * 0.30; // 30% der Bildschirmhöhe für die Chart-Sektion

    return Scaffold(
      body: Stack(
        children: [
          // Fixierter Hintergrund mit Farbverlauf
          Container(
            decoration: BoxDecoration(
              gradient: isPositive
                  ? AppColors.positiveGradient
                  : AppColors.negativeGradient,
            ),
            height: appBarHeight + chartHeight,
          ),
          Column(
            children: [
              // AppBar
              AppBar(
                title: Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                backgroundColor: Colors.transparent,
                centerTitle: true,
                elevation: 0,
                iconTheme: IconThemeData(color: Colors.white),
                actions: [
                  IconButton(onPressed: (){
                    //Weiterleitungs auf BearbeitungsWidget
                  }, icon: Icon(Icons.edit, color: Colors.white))
                ],
              ),
              // Chart und Details
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: chartHeight, // Höhe der Chart-Sektion
                        color: Colors.transparent,
                        child: const Center(
                          child: Text('Chart Placeholder', style: TextStyle(color: Colors.white)),
                        ),
                      ),
                      // Detail information section
                      Text(
                        amount,
                        style: Theme.of(context).textTheme.displayMedium?.copyWith(color: Colors.white),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Kauf-Informationen',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      SizedBox(height: 10),
                      Container(
                        decoration: BoxDecoration(
                          color: isPositive ? AppColors.positiveColor : AppColors.negativeColor,
                        ),
                        padding: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                Text(quantity, style: TextStyle(fontSize: 16, color: Colors.white)),
                                Text('Stück', style: TextStyle(fontSize: 12, color: Colors.white)),
                              ],
                            ),
                            Column(
                              children: [
                                Text(currentPrice, style: TextStyle(fontSize: 16, color: Colors.white)),
                                Text('aktueller Kurs', style: TextStyle(fontSize: 12, color: Colors.white)),
                              ],
                            ),
                            Column(
                              children: [
                                Text('10.01.21', style: TextStyle(fontSize: 16, color: Colors.white)),
                                Text('Kaufdatum', style: TextStyle(fontSize: 12, color: Colors.white)),
                              ],
                            ),
                            Column(
                              children: [
                                Text(purchasePrice, style: TextStyle(fontSize: 16, color: Colors.white)),
                                Text('Kaufkurs', style: TextStyle(fontSize: 12, color: Colors.white)),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Positionen',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      SizedBox(height: 10),
                      ListTile(
                        title: Text('Microsoft Corp', style: TextStyle(color: Colors.white)),
                        trailing: Text('6,97%', style: TextStyle(color: Colors.white)),
                      ),
                      ListTile(
                        title: Text('Apple Inc', style: TextStyle(color: Colors.white)),
                        trailing: Text('6,07%', style: TextStyle(color: Colors.white)),
                      ),
                      ListTile(
                        title: Text('Nvidia Corp', style: TextStyle(color: Colors.white)),
                        trailing: Text('5,13%', style: TextStyle(color: Colors.white)),
                      ),
                      ListTile(
                        title: Text('...', style: TextStyle(color: Colors.white)),
                        trailing: Text('...%', style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: CustomNavigationBar(),
    );
  }
}
