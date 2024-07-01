
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:androidproject/models/AssetPriceData.dart';
import 'package:androidproject/models/element.dart';
import 'package:androidproject/views/dashboard/dashboard_widget/portfolio_element_list.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../models/asset.dart';
import '../models/response_object.dart';
import '../utils/error_translator.dart';

class AssetEndpoint {
  static final Map<String, Asset?> _assetCache = {};

  static Future<ResponseObject> loadAssetPrice(String ticker) async {
    var completer = Completer<ResponseObject>();

    // Check if the portfolio is already in the cache
    if(_assetCache.containsKey(ticker)) {
      completer.complete(ResponseObject(
          message: ErrorTranslator.trans("load_successful"),
          success: true,
          data: _assetCache[ticker]));
      return completer.future;
    }

    // Grab Auth Token from storage
    const storage = FlutterSecureStorage();
    var authToken = await storage.read(key: "token");

    // Send login request to backend
    var result = await http.get(Uri.parse('${dotenv.env["API_URL"]}/assets/ticker/$ticker'), headers: {
      "Content-Type": "application/json",
      HttpHeaders.authorizationHeader: 'Bearer $authToken',
    })
        .timeout(const Duration(seconds: 10),
        onTimeout: () {
          return http.Response(jsonEncode({"message": "server_unreachable"}), 408);
        }
    );

    // Process the result of the http request
    Map<String, dynamic> jsonBody = jsonDecode(result.body) as Map<String, dynamic>;
    if(result.statusCode == 200) {
      if(jsonBody["response"]["quoteType"] == "CRYPTOCURRENCY") {
        completer.complete(ResponseObject(message: ErrorTranslator.trans("load_successful"), success: true, data: 0.0));
      } else {
        completer.complete(ResponseObject(message: ErrorTranslator.trans("load_successful"), success: true, data: jsonBody["response"]["bid"] as double));
      }
    } else {
      completer.completeError(ResponseObject(message: ErrorTranslator.trans(jsonBody["message"]), success: true));
    }

    return completer.future;
  }

  static Future<ResponseObject> loadAssetPriceData(String ticker, String interval, String period) async {
    var completer = Completer<ResponseObject>();

    // Grab Auth Token from storage
    const storage = FlutterSecureStorage();
    var authToken = await storage.read(key: "token");

    // Get Price Data from backend
    var result = await http.get(Uri.parse('${dotenv.env["API_URL"]}/assets/ticker/$ticker/priceData?period=$period&interval=$interval'), headers: {
      "Content-Type": "application/json",
      HttpHeaders.authorizationHeader: 'Bearer $authToken',
    })
        .timeout(const Duration(seconds: 10),
        onTimeout: () {
          return http.Response(jsonEncode({"message": "server_unreachable"}), 408);
        }
    );

    // Process the result of the http request
    Map<String, dynamic> jsonBody = jsonDecode(result.body) as Map<String, dynamic>;
    if(result.statusCode == 200) {
      List<AssetPriceData> priceDataList = List.empty(growable: true);
      for (var priceData in jsonBody["response"]) {
        priceDataList.add(AssetPriceData.fromJson(priceData));
      }
      completer.complete(ResponseObject(message: ErrorTranslator.trans("load_successful"), success: true, data: priceDataList));
    } else {
      completer.completeError(ResponseObject(message: ErrorTranslator.trans(jsonBody["message"]), success: true));
    }

    return completer.future;
  }

  static Future<ResponseObject> loadAssetCurrentPrice(String ticker) async {
    var completer = Completer<ResponseObject>();

    // Grab Auth Token from storage
    const storage = FlutterSecureStorage();
    var authToken = await storage.read(key: "token");

    // Get Price Data from backend
    var result = await http.get(Uri.parse('${dotenv.env["API_URL"]}/assets/ticker/$ticker/currentPrice'), headers: {
      "Content-Type": "application/json",
      HttpHeaders.authorizationHeader: 'Bearer $authToken',
    })
        .timeout(const Duration(seconds: 10),
        onTimeout: () {
          return http.Response(jsonEncode({"message": "server_unreachable"}), 408);
        }
    );

    // Process the result of the http request
    Map<String, dynamic> jsonBody = jsonDecode(result.body) as Map<String, dynamic>;
    if(result.statusCode == 200) {
      completer.complete(ResponseObject(message: ErrorTranslator.trans("load_successful"), success: true, data: jsonBody["response"]["price"]));
    } else {
      completer.completeError(ResponseObject(message: ErrorTranslator.trans(jsonBody["message"]), success: false));
    }

    return completer.future;
  }

  static Future<ResponseObject> search(String query) async {
    var completer = Completer<ResponseObject>();

    // Grab Auth Token from storage
    const storage = FlutterSecureStorage();
    var authToken = await storage.read(key: "token");

    // Send login request to backend
    var result = await http.get(Uri.parse('${dotenv.env["API_URL"]}/assets/search?query=$query'), headers: {
      "Content-Type": "application/json",
      HttpHeaders.authorizationHeader: 'Bearer $authToken',
    })
        .timeout(const Duration(seconds: 10),
        onTimeout: () {
          return http.Response(jsonEncode({"message": "server_unreachable"}), 408);
        }
    );

    // Process the result of the http request
    Map<String, dynamic> jsonBody = jsonDecode(result.body) as Map<String, dynamic>;
    if(result.statusCode == 200) {
      List<PortfolioElement> elementList = List.empty(growable: true);
      for (var element in jsonBody["response"]["assets"]) {
        elementList.add(PortfolioElement(
            1,
            0,
            0,
            Asset(
              element["shortname"],
              "",
              element["symbol"],
              element["quoteType"],
              ""
            )

        ));
      }
      completer.complete(ResponseObject(message: ErrorTranslator.trans("load_successful"), success: true, data: elementList));
    } else {
      completer.completeError(ResponseObject(message: ErrorTranslator.trans(jsonBody["message"]), success: true));
    }

    return completer.future;
  }

  static Future<ResponseObject> add(PortfolioElement element, String porfolioId) async {
    var completer = Completer<ResponseObject>();

    // Grab Auth Token from storage
    const storage = FlutterSecureStorage();
    var authToken = await storage.read(key: "token");

    // Generate JSON body
    var body = {
      "asset_ticker": element.asset.tickerSymbol,
      "count": element.count,
      "buy_price": element.buyPrice,
      "order_fee": element.orderFee
    };

    // Send login request to backend
    var result = await http.post(Uri.parse('${dotenv.env["API_URL"]}/user/portfolios/$porfolioId/add'), body: jsonEncode(body), headers: {
      "Content-Type": "application/json",
      HttpHeaders.authorizationHeader: 'Bearer $authToken',
    })
        .timeout(const Duration(seconds: 10),
        onTimeout: () {
          return http.Response(jsonEncode({"message": "server_unreachable"}), 408);
        }
    );

    // Process the result of the http request
    Map<String, dynamic> jsonBody = jsonDecode(result.body) as Map<String, dynamic>;
    if(result.statusCode == 200) {
      List<PortfolioElement> elementList = List.empty(growable: true);
      completer.complete(ResponseObject(message: ErrorTranslator.trans("add_successful"), success: true));
    } else {
      completer.completeError(ResponseObject(message: ErrorTranslator.trans(jsonBody["message"]), success: false));
    }

    return completer.future;
  }
}