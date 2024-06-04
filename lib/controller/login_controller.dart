import 'dart:convert';

import 'package:androidproject/app_config.dart';
import 'package:androidproject/utils/http_error_handling.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginScreenController  {
  login(String email, String password) async {
    // Validate the input

    // Send login request to backend
    final loginBody = {
      'email': email,
      'password': password
    };
    var result = await http.post(Uri.parse('${AppConfig.apiUrl}/user/login'), body: jsonEncode(loginBody), headers: {"Content-Type": "application/json"});

    // Process the result of the http request
    if(result.statusCode == 200) {
      Map<String, dynamic> jsonBody = jsonDecode(result.body) as Map<String, dynamic>;
      const storage = FlutterSecureStorage();
      await storage.write(key: "token", value: jsonBody["auth_token"]);
      return {
        "success": true,
        "message": "login_successful"
      };
    } else {
      return HttpErrorHandling.handleHttpError(result);
    }
  }

  register(String email, String password, String confirmPassword) async {
    // Validate the input
    if(password.compareTo(confirmPassword) != 0) {
      return {
        "success": false,
        "message": "confirm_password_different"
      };
    }

    // Send register request to backend
    final registerBody = {
      'email': email,
      'password': password
    };
    final result = await http.post(Uri.parse('${AppConfig.apiUrl}/user/register'), body: jsonEncode(registerBody), headers: {"Content-Type": "application/json"});

    // Process the result of the http request
    if(result.statusCode == 201) {
      Map<String, dynamic> jsonBody = jsonDecode(result.body) as Map<String, dynamic>;
      const storage = FlutterSecureStorage();
      await storage.write(key: "token", value: jsonBody["auth_token"]);
      return {
        "success": true,
        "message": "registration_successful"
      };
    } else {
      return HttpErrorHandling.handleHttpError(result);
    }
  }
}