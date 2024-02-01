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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '\$${currentValue.toStringAsFixed(2)}',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Text(
            '${percentageChange.toStringAsFixed(2)}%',
            style: TextStyle(
              fontSize: 16,
              color: percentageChange >= 0 ? Colors.green : Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}

