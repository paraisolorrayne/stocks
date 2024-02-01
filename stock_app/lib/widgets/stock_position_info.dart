import 'package:flutter/material.dart';
import 'package:stock_app/models/stocks_model.dart';

class StockPositionInfo extends StatelessWidget {
  final StockPosition position;

  StockPositionInfo({required this.position});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              position.logoUrl,
              height: 100, // Adjust the size as needed
            ),
            SizedBox(height: 16),
            Text(
              position.name.toUpperCase(),
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              position.ticker,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 24,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Your position: ${position.quantity} stocks (\$${position.averagePrice.toStringAsFixed(2)})',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
