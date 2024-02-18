import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

class ApiClient {
  final _client = http.Client();
  final String _url = 'https://fakestoreapi.com/products';
  final _timeLimit = const Duration(seconds: 30);

  /// Get all product
  Future<List?> getProducts() async {
    try {
      var url = Uri.parse(_url);
      final response = await _client.get(url, headers: {"Content-Type": "application/json"}).timeout(_timeLimit);
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        log(response.body);
        List<dynamic> responseBody = jsonDecode(response.body);
        return responseBody;
        //   return ProductDetailsResponse.fromJson(jsonDecode(response.body));
      } else {
        return null;
      }
    } catch (e, s) {
      log('Error : $e');
      log('Error : $s');
      return null;
    }
  }
}
