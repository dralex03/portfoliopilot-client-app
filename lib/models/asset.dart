import 'package:androidproject/models/AssetPriceData.dart';

class Asset  {
  final String id;
  final String name;
  final String isin;
  final String tickerSymbol;
  final String type;
  final String defaultCurrency;
  late List<AssetPriceData> priceData;

  Asset(
    this.id,
    this.name,
    this.isin,
    this.tickerSymbol,
    this.type,
    this.defaultCurrency
  );

  Asset.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String,
        name = json['name'] as String,
        isin = json['isin'] as String? ?? "",
        tickerSymbol = json['ticker_symbol'] as String,
        type = json['asset_type']["quote_type"] as String,
        defaultCurrency = json['default_currency'] as String;

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'isin': isin,
    'ticker_symbol': tickerSymbol,
    'type': type,
    'default_currency': defaultCurrency
  };
}
