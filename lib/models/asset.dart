import 'package:androidproject/models/AssetPriceData.dart';

class Asset  {
  final String name;
  final String isin;
  final String tickerSymbol;
  final String type;
  final String defaultCurrency;
  late double currentPrice;
  late List<AssetPriceData> priceData;

  Asset(
    this.name,
    this.isin,
    this.tickerSymbol,
    this.type,
    this.defaultCurrency
  );

  Asset.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String,
        isin = json['isin'] as String? ?? "",
        tickerSymbol = json['ticker_symbol'] as String,
        type = json['asset_type']["quote_type"] as String,
        defaultCurrency = json['default_currency'] as String;

  Map<String, dynamic> toJson() => {
    'name': name,
    'isin': isin,
    'ticker_symbol': tickerSymbol,
    'type': type,
    'default_currency': defaultCurrency
  };
}
