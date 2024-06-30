import 'dart:ffi';

import 'asset.dart';

class PortfolioElement {
  final double count;
  final double orderFee;
  final double buyPrice;
  Asset asset;

  PortfolioElement(
      this.count,
      this.orderFee,
      this.buyPrice,
      this.asset
      );

  PortfolioElement.fromJson(Map<String, dynamic> json)
      : count = json['count'] as double,
        orderFee = json['order_fee'] as double,
        buyPrice = json['buy_price'] as double,
        asset = Asset.fromJson(json['asset']);

  Map<String, dynamic> toJson() => {
    'count': count,
    'order_fee': orderFee,
    'buy_price': buyPrice,
    'asset': asset.toJson()
  };

  bool isPositive() {
    return asset.priceData.last.close > buyPrice;
  }
}
