import 'dart:convert';

import 'package:androidproject/app_config.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../utils/error_translator.dart';

class LoginScreenController  {
  login(String email, String password) async {
    // Validate the input
    if(email.isEmpty || password.isEmpty) {
      return {
        "success": false,
        "message": ErrorTranslator.trans("empty_fields")
      };
    }

    // Send login request to backend
    final loginBody = {
      'email': email,
      'password': password
    };
    var result;
    result = await http.post(Uri.parse('${AppConfig.apiUrl}/user/login'), body: jsonEncode(loginBody), headers: {"Content-Type": "application/json"})
      .timeout(const Duration(seconds: 5),
        onTimeout: () {
          return http.Response(jsonEncode({"message": "server_unreachable"}), 408);
        }
      );

    // Process the result of the http request
    Map<String, dynamic> jsonBody = jsonDecode(result.body) as Map<String, dynamic>;
    if(result.statusCode == 200) {
      Map<String, dynamic> jsonBody = jsonDecode(result.body) as Map<String, dynamic>;
      const storage = FlutterSecureStorage();
      await storage.write(key: "token", value: jsonBody["auth_token"]);
      return {
        "success": true,
        "message": ErrorTranslator.trans("login_successful")
      };
    } else {
      return {
        "success": false,
        "message": ErrorTranslator.trans(jsonBody["message"])
      };
    }
  }

  register(String email, String password, String confirmPassword) async {
    // Validate the input
    if(email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      return {
        "success": false,
        "message": ErrorTranslator.trans("empty_fields")
      };
    }
    if(password.compareTo(confirmPassword) != 0) {
      return {
        "success": false,
        "message": ErrorTranslator.trans("confirm_password_different")
      };
    }

    // Send register request to backend
    final registerBody = {
      'email': email,
      'password': password
    };
    var result = await http.post(Uri.parse('${AppConfig.apiUrl}/user/register'), body: jsonEncode(registerBody), headers: {"Content-Type": "application/json"})
      .timeout(const Duration(seconds: 5),
        onTimeout: () {
          return http.Response(jsonEncode({"message": "server_unreachable"}), 408);
        }
      );

    // Process the result of the http request
    Map<String, dynamic> jsonBody = jsonDecode(result.body) as Map<String, dynamic>;
    if(result.statusCode == 201) {
      const storage = FlutterSecureStorage();
      await storage.write(key: "token", value: jsonBody["auth_token"]);
      return {
        "success": true,
        "message": "registration_successful"
      };
    } else {
      return {
        "success": false,
        "message": ErrorTranslator.trans(jsonBody["message"])
      };
    }
  }
}