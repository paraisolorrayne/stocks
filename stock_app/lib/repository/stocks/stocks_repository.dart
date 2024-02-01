import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:stock_app/models/stocks_model.dart';
import 'package:stock_app/constants/constants.dart';

class StocksRepository {
  final http.Client httpClient;
  final String baseUrl = ApiConstants.baseUrl;


  StocksRepository({http.Client? httpClient})
      : this.httpClient = httpClient ?? http.Client();

  Future<StocksModel> fetchStocks(String token) async {
    final response = await this.httpClient.get(
      Uri.parse('$baseUrl/portfolio'),
      headers: {
        'Authorization': token,
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return StocksModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load stocks');
    }
  }

  
}
