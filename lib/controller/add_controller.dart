import 'dart:async';

import 'package:androidproject/models/element.dart';
import 'package:androidproject/services/asset_endpoint.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/asset.dart';
import '../models/portfolio.dart';
import '../models/response_object.dart';
import 'dashboard_controller.dart';

class AddController {
  Future<ResponseObject> searchAssets(String query) async {
    var completer = Completer<ResponseObject>();

    var portfolioResponse = await AssetEndpoint.search(query);
    if(portfolioResponse.success) {
      completer.complete(ResponseObject(message: "load_successful", success: true, data: portfolioResponse.data));
    } else {
      completer.completeError(ResponseObject(message: "error_loading_portfolio", success: false));
    }
    return completer.future;
  }

  Future<ResponseObject> addAsset(String ticker, double quantity, double orderFee, double purchasePrice) async {
    var completer = Completer<ResponseObject>();

    PortfolioElement el = PortfolioElement(
      quantity,
      orderFee,
      purchasePrice,
      Asset(
          "",
          "",
          ticker,
          "",
          ""
      )
    );

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String portfolioId = prefs.getString("current_portfolio_id") as String;

    var portfolioResponse = await AssetEndpoint.add(el, portfolioId);
    if(portfolioResponse.success) {
      completer.complete(ResponseObject(message: "load_successful", success: true, data: portfolioResponse.data));
    } else {
      completer.completeError(ResponseObject(message: "error_loading_portfolio", success: false));
    }
    return completer.future;
  }
}