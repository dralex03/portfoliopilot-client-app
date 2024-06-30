import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:androidproject/models/response_object.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../models/portfolio.dart';
import '../utils/error_translator.dart';

class PortfolioEndpoint {
  static final Map<String, Portfolio?> _portfolioCache = {};

  static Future<ResponseObject> loadPortfolio(String portfolioId) async {
    var completer = Completer<ResponseObject>();

    // Check if the portfolio is already in the cache
    if(_portfolioCache.containsKey(portfolioId)) {
      completer.complete(ResponseObject(
          message: ErrorTranslator.trans("load_successful"),
          success: true,
          data: _portfolioCache[portfolioId]));
      return completer.future;
    }

    // Grab Auth Token from storage
    const storage = FlutterSecureStorage();
    var authToken = await storage.read(key: "token");

    // Send login request to backend
    var result = await http.get(Uri.parse('${dotenv.env["API_URL"]}/user/portfolios/$portfolioId'), headers: {
      "Content-Type": "application/json",
      "Authorization": 'Bearer $authToken',
    })
        .timeout(const Duration(seconds: 10),
        onTimeout: () {
          return http.Response(jsonEncode({"message": "server_unreachable"}), 408);
        }
    );

    // Process the result of the http request
    Map<String, dynamic> jsonBody = jsonDecode(result.body) as Map<String, dynamic>;
    if(result.statusCode == 200) {
      var portfolio = Portfolio.fromJson(jsonBody["response"]);
      _portfolioCache[portfolioId] = portfolio;
      completer.complete(ResponseObject(message: ErrorTranslator.trans("load_successful"), success: true, data: portfolio));
    } else {
      completer.completeError(ResponseObject(message: ErrorTranslator.trans(jsonBody["message"]), success: false));
    }

    return completer.future;
  }

  Future<ResponseObject> createPortfolio(String ticker) async {
    var completer = Completer<ResponseObject>();

    completer.complete(ResponseObject(message: ErrorTranslator.trans("wip"), success: true));

    return completer.future;
  }

  static Future<ResponseObject> loadAllPortfolios() async {
    var completer = Completer<ResponseObject>();

    // Grab Auth Token from storage
    const storage = FlutterSecureStorage();
    var authToken = await storage.read(key: "token");

    // Send login request to backend
    var result = await http.get(Uri.parse('${dotenv.env["API_URL"]}/user/portfolios'), headers: {
      "Content-Type": "application/json",
      "Authorization": 'Bearer $authToken',
    })
        .timeout(const Duration(seconds: 10),
        onTimeout: () {
          return http.Response(jsonEncode({"message": "server_unreachable"}), 408);
        }
    );

    // Process the result of the http request
    Map<String, dynamic> jsonBody = jsonDecode(result.body) as Map<String, dynamic>;
    if(result.statusCode == 200) {
      List<Portfolio> portfolioList = List.empty(growable: true);
      for (var portfolioJson in jsonBody["response"] as List) {
        Portfolio portfolio = Portfolio.fromJson(portfolioJson);
        _portfolioCache[portfolio.id] = portfolio;
        portfolioList.add(portfolio);
      }
      completer.complete(ResponseObject(message: ErrorTranslator.trans("load_successful"), success: true, data: portfolioList));
    } else {
      completer.completeError(ResponseObject(message: ErrorTranslator.trans(jsonBody["message"]), success: false));
    }

    return completer.future;
  }
}