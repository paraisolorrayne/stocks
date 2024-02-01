import 'package:flutter/material.dart';
import 'package:stock_app/models/stocks_model.dart';
class StockList extends StatelessWidget {
  final List<StockPosition> stocks;

  StockList({required this.stocks});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: stocks.length,
      itemBuilder: (context, index) {
        final stock = stocks[index];
        return ListTile(
          leading: Image.network(stock.logoUrl),
          title: Text(stock.name),
          subtitle: Text('stocks'),
          trailing: Text('\$${stock.lastPrice.toString()}'),
        );
      },
    );
  }
}
//${stock.quantity}