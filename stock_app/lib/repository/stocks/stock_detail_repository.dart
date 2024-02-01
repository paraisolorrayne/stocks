import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:stock_app/constants/constants.dart';
import 'package:stock_app/models/stock_detail.dart';

class StockDetailRepository {
  final http.Client httpClient;
  final String baseUrl = ApiConstants.baseUrl;

  StockDetailRepository({http.Client? httpClient})
      : this.httpClient = httpClient ?? http.Client();

  Future<StockDetail> getStockDetail(String token, String symbol) async {
    final response = await this.httpClient.get(
      Uri.parse('$baseUrl/symbol/$symbol'),
      headers: {
        'Authorization': token,
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final stockDetailJson = json.decode(response.body);
      return StockDetail.fromJson(stockDetailJson);
    } else {
      throw Exception('Failed to load stock detail');
    }
  }
}
