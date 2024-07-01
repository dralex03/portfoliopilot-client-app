import 'dart:async';

import 'package:androidproject/services/portfolio_endpoint.dart';
import '../models/response_object.dart';

class ProfileController {
  /// creates login request user with the given credentials and sends it to the backend
  Future<ResponseObject> createPortfolio(String name) async {
    var completer = Completer<ResponseObject>();

    ResponseObject res = await PortfolioEndpoint.createPortfolio(name);
    if(res.success) {
      completer.complete(ResponseObject(message: "create_successful", success: true));
    } else {
      completer.complete(ResponseObject(message: "create_errored", success: false));
    }

    return completer.future;
  }
}