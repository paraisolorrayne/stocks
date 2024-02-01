class StocksModel {
  final double currentValue;
  final double initialInvestment;
  final List<StockPosition> positions;

  StocksModel({
    required this.currentValue,
    required this.initialInvestment,
    required this.positions,
  });

  double get percentageChange => ((currentValue - initialInvestment) / initialInvestment) * 100;

  factory StocksModel.fromJson(Map<String, dynamic> json) {
    var positionsList = json['positions'] as List;
    List<StockPosition> positions = positionsList.map((i) => StockPosition.fromJson(i)).toList();

    return StocksModel(
      currentValue: json['current_value'],
      initialInvestment: json['initial_investment'],
      positions: positions,
    );
  }
}

class StockPosition {
  final String ticker;
  final String name;
  final int quantity;
  final double averagePrice;
  final String lastPrice;
  final String currency;
  final String type;
  final String logoUrl;

  StockPosition({
    required this.ticker,
    required this.name,
    required this.quantity,
    required this.averagePrice,
    required this.lastPrice,
    required this.currency,
    required this.type,
    required this.logoUrl,
  });

  factory StockPosition.fromJson(Map<String, dynamic> json) {
    return StockPosition(
      ticker: json['ticker'],
      name: json['name'],
      quantity: json['quantity'],
      averagePrice: json['average_price'],
      lastPrice: json['last_price'],
      currency: json['currency'],
      type: json['type'],
      logoUrl: json['logo_url'],
    );
  }
}
