import 'dart:async';

import 'package:androidproject/models/AssetPriceData.dart';
import 'package:androidproject/models/asset.dart';
import 'package:androidproject/models/response_object.dart';
import 'package:androidproject/services/asset_endpoint.dart';
import 'package:androidproject/services/portfolio_endpoint.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/element.dart';
import '../models/portfolio.dart';

class DashboardController {

  /// Catches the current portfolio id from the shared preferences.
  Future<String> getCurrentPortfolioId() async {
    var completer = Completer<String>();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    completer.complete(prefs.getString("current_portfolio_id"));
    return completer.future;
  }

  /// Loads all elements of the current portfolio with the price data of the assets.
  Future<ResponseObject> loadElementsWithPriceData() async {
    var completer = Completer<ResponseObject>();

    // Get current portfolio ID
    String portfolioId = await getCurrentPortfolioId();

    // Load the portfolio with the ID through service
    var portfolioResponse = await PortfolioEndpoint.loadPortfolio(portfolioId);
    Portfolio portfolio;
    if(portfolioResponse.success) {
      portfolio = portfolioResponse.data as Portfolio;
    } else {
      completer.completeError(ResponseObject(message: "error_loading_portfolio", success: false));
      return completer.future;
    }

    // Load the price data for each asset in the portfolio
    for (var element in portfolio.elements) {
      var priceData = await AssetEndpoint.loadAssetCurrentPrice(element.asset.tickerSymbol);
      if(priceData.success) {
        portfolio.elements[portfolio.elements.indexOf(element)].asset.currentPrice = priceData.data as double;
      } else {
        completer.complete(ResponseObject(message: "error_loading_assets", success: false));
        return completer.future;
      }
    }
    completer.complete(ResponseObject(message: "load_successful", success: true, data: portfolio.elements));

    return completer.future;
  }

  Future<ResponseObject> loadAllPortfolios() async {
    var completer = Completer<ResponseObject>();

    // Load all portfolios through service
    var portfolioResponse = await PortfolioEndpoint.loadAllPortfolios();
    if(portfolioResponse.success) {
      completer.complete(ResponseObject(message: "load_successful", success: true, data: portfolioResponse.data));
    } else {
      completer.completeError(ResponseObject(message: "error_loading_portfolio", success: false));
    }
    return completer.future;
  }

  // Load all portfolios of user
  Future<ResponseObject> loadPortfolio() async {
    var completer = Completer<ResponseObject>();

    // Get current portfolio ID
    String portfolioId = await getCurrentPortfolioId();

    // Load the portfolio with the ID through service
    var portfolioResponse = await PortfolioEndpoint.loadPortfolio(portfolioId);
    if(portfolioResponse.success) {
      completer.complete(ResponseObject(message: "load_successful", success: true, data: portfolioResponse.data));
    } else {
      completer.completeError(ResponseObject(message: "error_loading_portfolio", success: false));
    }
    return completer.future;
  }

  // Get total value of selected portfolio
  Future<ResponseObject> getTotalValue() async {
    var completer = Completer<ResponseObject>();

    // Load all portfolio elements with their price data
    var portfolioResponse = await loadElementsWithPriceData();
    if(portfolioResponse.success) {
      List<PortfolioElement> elements = portfolioResponse.data;
      if(elements.isEmpty) {
        completer.complete(ResponseObject(message: "no_portfolios_found", success: true, data: {0.0, 1.0}));
        return completer.future;
      }
      double totalValue = 0;
      double totalDiff = 0;

      // Sum up the total values and the total differences for each element
      for (var element in elements) {
        totalValue += element.asset.currentPrice * element.count;
        totalDiff += (element.asset.currentPrice - element.buyPrice) * element.count;
      }
      completer.complete(ResponseObject(message: "load_successful", success: true, data: {totalValue, totalDiff}));
    } else {
      completer.completeError(ResponseObject(message: "error_loading_portfolio", success: false));
    }
    return completer.future;
  }
}