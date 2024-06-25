import 'asset.dart';

class Portfolio  {
  final String id;
  final String name;
  final List<Asset> elements;

  const Portfolio(
    this.id,
    this.name,
    this.elements
  );

  Portfolio.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String,
        name = json['name'] as String,
        elements = json['elements'] as List<Asset>;

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
  };
}
