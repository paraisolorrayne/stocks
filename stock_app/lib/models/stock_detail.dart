class StockDetail {
  final String ticker;
  final String name;
  final double lastPrice;
  final String currency;
  final String type;
  final String logoUrl;
  final String description;
  final String website;
  final String sector;
  final String industry;
  final String phoneNumber;
  final String address;
  final DateTime ipoDate;

  StockDetail({
    required this.ticker,
    required this.name,
    required this.lastPrice,
    required this.currency,
    required this.type,
    required this.logoUrl,
    required this.description,
    required this.website,
    required this.sector,
    required this.industry,
    required this.phoneNumber,
    required this.address,
    required this.ipoDate,
  });

  factory StockDetail.fromJson(Map<String, dynamic> json) {
    return StockDetail(
      ticker: json['ticker'],
      name: json['name'],
      lastPrice: (json['last_price'] as num).toDouble(),
      currency: json['currency'],
      type: json['type'],
      logoUrl: json['logo_url'],
      description: json['description'],
      website: json['website'],
      sector: json['sector'],
      industry: json['industry'],
      phoneNumber: json['phone_number'],
      address: json['address'],
      ipoDate: DateTime.parse(json['ipo_date']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ticker': ticker,
      'name': name,
      'last_price': lastPrice,
      'currency': currency,
      'type': type,
      'logo_url': logoUrl,
      'description': description,
      'website': website,
      'sector': sector,
      'industry': industry,
      'phone_number': phoneNumber,
      'address': address,
      'ipo_date': ipoDate.toIso8601String(),
    };
  }
}
