import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:luminar_api_sample_april_2025/app_config/app_config.dart';

class ApiServices {
  static Future<String?> getData({
    required String enpointUrl,
    Map<String, String>? headers,
  }) async {
    final url = Uri.parse("${AppConfig.baseUrl}$enpointUrl");
    final response = await http.get(url, headers: headers);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return response.body;
    }
    return null;
  }

  static Future<String?> postData({
    required String enpointUrl,
    Map? postBody,
    Map<String, String>? headers,
  }) async {
    final url = Uri.parse("${AppConfig.baseUrl}$enpointUrl");
    final response = await http.post(
      url,
      body: jsonEncode(postBody),
      headers: headers,
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return response.body;
    }
    return null;
  }

  static Future<String?> putData({
    required String enpointUrl,
    Map? postBody,
    Map<String, String>? headers,
  }) async {
    final url = Uri.parse("${AppConfig.baseUrl}$enpointUrl");
    final response = await http.put(
      url,
      body: jsonEncode(postBody),
      headers: headers,
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return response.body;
    }
    return null;
  }

  static Future<String?> patchData({
    required String enpointUrl,
    Map? postBody,
    Map<String, String>? headers,
  }) async {
    final url = Uri.parse("${AppConfig.baseUrl}$enpointUrl");
    final response = await http.patch(
      url,
      body: jsonEncode(postBody),
      headers: headers,
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return response.body;
    }
    return null;
  }

  static Future<String?> deleteData({
    required String enpointUrl,
    Map? postBody,
    Map<String, String>? headers,
  }) async {
    final url = Uri.parse("${AppConfig.baseUrl}$enpointUrl");
    final response = await http.delete(url, body: postBody, headers: headers);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return response.body;
    }
    return null;
  }
}
