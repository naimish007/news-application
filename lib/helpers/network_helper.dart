import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../theme/app_config.dart';
import 'exception_handler.dart';

class NetworkAPICall {
  static final NetworkAPICall _networkAPICall = NetworkAPICall._internal();

  factory NetworkAPICall() {
    return _networkAPICall;
  }

  NetworkAPICall._internal();

  static const String baseUrl = AppConfig.baseURL;

  Future<dynamic> get(String url) async {
    final client = http.Client();
    try {
      final String fullURL = baseUrl + url;
      log('API Url: $fullURL');
      final response = await client.get(Uri.parse(fullURL));
      log('Response status: ${response.statusCode}');
      log('Response body: ${response.body}');
      return checkResponse(response);
    } catch (e) {
      client.close();
      rethrow;
    }
  }

  dynamic checkResponse(http.Response response) {
    try {
      switch (response.statusCode) {
        case 200:
          try {
            if (response.body.isEmpty) {
              throw AppException(message: "Empty Body", errorCode: 0);
            }
            return jsonDecode(response.body);
          } catch (e) {
            rethrow;
          }
        case 201:
          try {
            if (response.body.isEmpty) {
              throw AppException(message: "Empty Body", errorCode: 0);
            }
            return jsonDecode(response.body);
          } catch (e) {
            rethrow;
          }
        case 401:
          throw AppException(message: "badResponse", errorCode: response.statusCode);
        default:
          try {
            if (response.body.isEmpty) {
              throw AppException(message: "Empty Body", errorCode: response.statusCode);
            }
            final Map<String, dynamic> data = jsonDecode(response.body);
            throw AppException(message: "error : ${data['Error']}", errorCode: response.statusCode);
          } catch (e) {
            rethrow;
          }
      }
    } catch (e) {
      rethrow;
    }
  }
}
