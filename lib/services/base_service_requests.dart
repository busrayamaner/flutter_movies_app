import 'package:flutter/material.dart';
import 'package:http/http.dart';

class BaseServiceRequests {
  static Future<Response?> getRequest(String path) async {
    try {
      Uri apiAddress = Uri.parse(path);
      Response response = await get(apiAddress, headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      });
      return response;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}
