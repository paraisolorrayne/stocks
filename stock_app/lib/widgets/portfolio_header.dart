import 'package:flutter/material.dart';

class PortfolioHeader extends StatelessWidget {
  final double currentValue;
  final double percentageChange;

  PortfolioHeader({required this.currentValue, required this.percentageChange});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      color: Colors.grey[200], // Choose your color
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              '\$ ${currentValue.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 8), // Adjust the height for your spacing needs
          Center(
            child: Text(
              '${percentageChange.toStringAsFixed(2)}%',
              style: TextStyle(
                fontSize: 16,
                color: percentageChange >= 0 ? Colors.green : Colors.red,
              ),
            ),
          ),
          SizedBox(height: 24), // This SizedBox provides the large space between the texts
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Stocks:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Order by: amount of shares',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
