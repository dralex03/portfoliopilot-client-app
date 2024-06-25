class Asset  {
  final String id;
  final String title;
  final String amount;
  final String quantity;
  final String currentPrice;
  final String purchasePrice;
  final bool isPositive;

  const Asset(
    this.id,
    this.title,
    this.amount,
    this.quantity,
    this.currentPrice,
    this.purchasePrice,
    this.isPositive
  );

  Asset.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String,
        title = json['name'] as String,
        amount = json['amount'] as String,
        quantity = json['quantity'] as String,
        currentPrice = json['currentPrice'] as String,
        purchasePrice = json['purchasePrice'] as String,
        isPositive = json['isPositive'] as bool;

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'amount': amount,
    'quantity': quantity,
    'currentPrice': currentPrice,
    'purchasePrice': purchasePrice,
    'isPositive': isPositive
  };
}
