import 'dart:ffi';

class AssetPriceData  {
  final double close;
  final double open;
  final double high;
  final double low;
  final DateTime date;

  AssetPriceData(
      this.close,
      this.open,
      this.high,
      this.low,
      this.date
      );

  AssetPriceData.fromJson(Map<String, dynamic> json)
      : close = json['Close'] as double,
        open = json['Open'] as double,
        high = json['High'] as double,
        low = json['Low'] as double,
        date = DateTime.parse(json["Datetime"]);
}
