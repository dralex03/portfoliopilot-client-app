import 'package:androidproject/models/element.dart';
import 'package:androidproject/models/portfolio.dart';
import 'package:androidproject/models/response_object.dart';
import 'package:flutter/material.dart';
import 'package:androidproject/utils/app_theme.dart';
import 'package:androidproject/views/dashboard/dashboard_widget/dashboard_app_bar.dart';
import 'package:androidproject/views/shared_widgets/navigation_bar.dart';
import 'package:androidproject/views/shared_widgets/chart_section.dart';
import 'package:androidproject/views/shared_widgets/total_value_section.dart';

import 'package:androidproject/controller/dashboard_controller.dart';
import 'package:androidproject/models/asset.dart';
import 'package:androidproject/services/service_locator.dart';
import 'package:androidproject/views/dashboard/dashboard_widget/portfolio_element_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// The main view for the dashboard, displaying the user's portfolios and their details.
class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  _DashboardViewState createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {

  final stateController = getIt<DashboardController>();


  // Handles changing the selected portfolio.
  void _onPortfolioChanged(String portfolioId) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double chartHeight = screenHeight * 0.3;

    return Scaffold(
      body: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: AppColors.neutralGradient,
            ),
            child: Column(
              children: [

                CustomAppBar(onPortfolioChanged: _onPortfolioChanged),
                // Section displaying a chart.
                ChartSection(
                  height: chartHeight,
                  isPositive: true, // Adjust based on our logic
                ),

                // Section displaying the total value of the portfolio.
                FutureBuilder(
                  future: stateController.getCurrentPortfolioId(),
                  builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error.toString()}'),
                      );
                    } else {
                      return FutureBuilder(
                        future: stateController.getTotalValue(),
                        builder: (BuildContext context, AsyncSnapshot<ResponseObject> snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (snapshot.hasError) {
                            //ResponseObject err = snapshot.error as ResponseObject;
                            return Center(
                              child: Text('Error: ${snapshot.error.toString()}'),
                            );
                          } else {
                            Set<double> data = snapshot.data!.data;
                            return TotalValueSection(
                              totalValue: '${data.elementAt(0).toStringAsFixed(2)}€ (${data.elementAt(1).toStringAsFixed(2)}€)',
                              isPositive: data.elementAt(1) >= 0,
                            );
                          }
                        },
                      );
                    }
                  },
                )
              ],
            ),
          ),

          // Scrollable section with a list of portfolio assets.
          Expanded(
            child: Container(
              color: AppColors.assetListColor,
              child: SingleChildScrollView(
                child: FutureBuilder(
                    future: stateController.loadElementsWithPriceData(),
                    builder: (BuildContext context, AsyncSnapshot<ResponseObject> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      /*return Center(
                        child: Text('Error: ${snapshot.error.toString()}'),
                      );*/
                      ResponseObject err = snapshot.error as ResponseObject;
                      return Center(
                        child: Text('Error: ${err.message}'),
                      );
                    } else {
                      List<PortfolioElement> elements = snapshot.data!.data.elements;
                      if(elements.isEmpty) {
                        return const Center(
                          child: Text('No assets found.'),
                        );
                      }
                      return Column(
                        children: [
                          const SizedBox(height: 10),
                          PortfolioElementList(
                            elements: elements,
                            onAssetSelected: (item) {
                              return 0;
                            },
                          ),
                        ],
                      );
                    }
                  })
                ,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const CustomNavigationBar(),
    );
  }
}
