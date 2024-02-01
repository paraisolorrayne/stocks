import 'package:flutter/material.dart';
import 'package:stock_app/models/stocks_model.dart';

class StockList extends StatelessWidget {
  final List<StockPosition> stocks;
  final Function(StockPosition) onStockTap;

  StockList({required this.stocks, required this.onStockTap});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: stocks.length,
      itemBuilder: (context, index) {
        final stock = stocks[index];
        return ListTile(
          onTap: () => onStockTap(stock),
          leading: Image.network(
            stock.logoUrl,
            width: 80,
            height: 60
          ),
          title: Text(stock.name),
          subtitle: Text('${stock.quantity.toString()} stocks'),
          trailing: Text(
            '\$ ${stock.lastPrice.toString()}',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        );
      },
    );
  }
}