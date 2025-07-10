class CryptoModel {
  final String id;
  final String name;
  final String symbol;
  final double currentPrice;
  final String image;
  final double priceChangePercentage24h;
  final double marketCap;

  CryptoModel({
    required this.id,
    required this.name,
    required this.symbol,
    required this.currentPrice,
    required this.image,
    required this.priceChangePercentage24h,
    required this.marketCap,
  });

  factory CryptoModel.fromJson(Map<String, dynamic> json) {
    return CryptoModel(
      id: json['id'],
      name: json['name'],
      symbol: json['symbol'],
      currentPrice: (json['current_price'] ?? 0).toDouble(),
      image: json['image'] ?? '',
      priceChangePercentage24h:
      (json['price_change_percentage_24h'] ?? 0).toDouble(),
      marketCap: json['market_cap']?.toDouble() ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'symbol': symbol,
    'current_price': currentPrice,
    'image': image,
    'price_change_percentage_24h': priceChangePercentage24h,
    'marketCap': marketCap,
  };

}

