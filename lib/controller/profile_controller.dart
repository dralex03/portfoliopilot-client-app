import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import '../utils/error_translator.dart';

class ProfileController {
  /// creates login request user with the given credentials and sends it to the backend
  createPortfolio(String name) async {
    // Validate the input
    if (name.isEmpty) {
      return {
        "success": false,
        "message": ErrorTranslator.trans("empty_fields")
      };
    }

    // Send login request to backend
    final loginBody = {
      'name': name
    };
    var result;
    result = await http.post(
        Uri.parse('${dotenv.env["API_URL"]}/user/portfolios'),
        body: jsonEncode(loginBody),
        headers: {"Content-Type": "application/json"})
        .timeout(const Duration(seconds: 5),
        onTimeout: () {
          return http.Response(
              jsonEncode({"message": "server_unreachable"}), 408);
        }
    );

    // Process the result of the http request
    Map<String, dynamic> jsonBody = jsonDecode(result.body) as Map<
        String,
        dynamic>;
    if (result.statusCode == 200) {
      return {
        "success": true,
        "message": ErrorTranslator.trans("add_successful")
      };
    } else {
      return {
        "success": false,
        "message": ErrorTranslator.trans(jsonBody["message"])
      };
    }
  }
}