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

  Future<String> getCurrentPortfolioId() async {
    var completer = Completer<String>();

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if(!prefs.containsKey("current_portfolio_id") || prefs.getString("current_portfolio_id") == null) {
      List<Portfolio> portfolioList = (await loadAllPortfolios()).data as List<Portfolio>;
      prefs.setString("current_portfolio_id", portfolioList[0].id);
    }
    completer.complete(prefs.getString("current_portfolio_id"));
    return completer.future;
  }

  Future<ResponseObject> loadElementsWithPriceData() async {
    var completer = Completer<ResponseObject>();

    String portfolioId = await getCurrentPortfolioId();

    var portfolioResponse = await PortfolioEndpoint.loadPortfolio(portfolioId);
    Portfolio portfolio;
    if(portfolioResponse.success) {
      portfolio = portfolioResponse.data as Portfolio;
    } else {
      completer.completeError(ResponseObject(message: "error_loading_portfolio", success: false));
      return completer.future;
    }

    for (var element in portfolio.elements) {
      var priceData = await AssetEndpoint.loadAssetPriceData(element.asset.tickerSymbol, "1d", "1d");
      if(priceData.success) {
        portfolio.elements[portfolio.elements.indexOf(element)].asset.priceData = priceData.data as List<AssetPriceData>;
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

    var portfolioResponse = await PortfolioEndpoint.loadAllPortfolios();
    if(portfolioResponse.success) {
      completer.complete(ResponseObject(message: "load_successful", success: true, data: portfolioResponse.data));
    } else {
      completer.completeError(ResponseObject(message: "error_loading_portfolio", success: false));
    }
    return completer.future;
  }

  Future<ResponseObject> loadPortfolio() async {
    var completer = Completer<ResponseObject>();

    String portfolioId = await getCurrentPortfolioId();

    var portfolioResponse = await PortfolioEndpoint.loadPortfolio(portfolioId);
    if(portfolioResponse.success) {
      completer.complete(ResponseObject(message: "load_successful", success: true, data: portfolioResponse.data));
    } else {
      completer.completeError(ResponseObject(message: "error_loading_portfolio", success: false));
    }
    return completer.future;
  }

  Future<ResponseObject> getTotalValue() async {
    var completer = Completer<ResponseObject>();

    var portfolioResponse = await loadElementsWithPriceData();
    if(portfolioResponse.success) {
      List<PortfolioElement> elements = portfolioResponse.data;
      if(elements.isEmpty) {
        completer.complete(ResponseObject(message: "no_portfolios_found", success: true, data: {0.0, 1.0}));
        return completer.future;
      }
      double totalValue = 0;
      double totalDiff = 0;
      for (var element in elements) {
        totalValue += element.asset.priceData.last.close * element.count;
        totalDiff += (element.asset.priceData.last.close - element.buyPrice) * element.count;
      }
      completer.complete(ResponseObject(message: "load_successful", success: true, data: {totalValue, totalDiff}));
    } else {
      completer.completeError(ResponseObject(message: "error_loading_portfolio", success: false));
    }
    return completer.future;
  }
}