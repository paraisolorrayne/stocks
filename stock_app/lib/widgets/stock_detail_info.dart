import 'package:flutter/material.dart';
import 'package:stock_app/models/stock_detail.dart';
import 'package:stock_app/models/stocks_model.dart';

class StockDetailInfo extends StatelessWidget {
  final StockDetail stockDetail;
  final StockPosition stockPosition;

  const StockDetailInfo({Key? key, required this.stockDetail, required this.stockPosition}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16), // Space from top
            Text(
              stockDetail.name,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              stockDetail.ticker,
              style: TextStyle(
                fontSize: 24,
                color: Colors.grey,
              ),
            ),
            Divider(height: 24), // Visual divider
            Text(
              stockDetail.description,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 24),
            Text(
              'Your position: ${stockPosition.quantity} stocks (${stockPosition.averagePrice.toStringAsFixed(2)})',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Last price: ${stockDetail.lastPrice.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Text('Address: ${stockDetail.address}'),
            Text('Website: ${stockDetail.website}'),
            Text('Phone: ${stockDetail.phoneNumber}'),
            Text('Sector: ${stockDetail.sector}'),
            // Add more fields as necessary
          ],
        ),
      ),
    );
  }
}
