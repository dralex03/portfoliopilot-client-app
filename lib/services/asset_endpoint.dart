
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:androidproject/models/AssetPriceData.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../models/asset.dart';
import '../models/response_object.dart';
import '../utils/error_translator.dart';

class AssetEndpoint {
  static final Map<int, Asset?> _assetCache = {};

  static Future<ResponseObject> loadAsset(String ticker) async {
    var completer = Completer<ResponseObject>();

    // Check if the portfolio is already in the cache
    if(_assetCache.containsKey(int.parse(ticker))) {
      completer.complete(ResponseObject(
          message: ErrorTranslator.trans("load_successful"),
          success: true,
          data: _assetCache[int.parse(ticker)]));
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
        .timeout(const Duration(seconds: 5),
        onTimeout: () {
          return http.Response(jsonEncode({"message": "server_unreachable"}), 408);
        }
    );

    // Process the result of the http request
    Map<String, dynamic> jsonBody = jsonDecode(result.body) as Map<String, dynamic>;
    if(result.statusCode == 200) {
      var asset = Asset.fromJson(jsonBody["response"]);
      _assetCache[int.parse(ticker)] = asset;
      completer.complete(ResponseObject(message: ErrorTranslator.trans("load_successful"), success: true, data: asset));
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

    // Send login request to backend
    var result = await http.get(Uri.parse('${dotenv.env["API_URL"]}/assets/ticker/$ticker/priceData?period=$period&interval=$interval'), headers: {
      "Content-Type": "application/json",
      HttpHeaders.authorizationHeader: 'Bearer $authToken',
    })
        .timeout(const Duration(seconds: 5),
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
}