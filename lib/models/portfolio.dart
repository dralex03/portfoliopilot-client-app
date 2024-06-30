import 'element.dart';

class Portfolio  {
  final String id;
  final String name;
  final List<PortfolioElement> elements;

  const Portfolio(
    this.id,
    this.name,
    this.elements
  );

  Portfolio.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String,
        name = json['name'] as String,
        elements = (json['elements'] as List).map((e) => PortfolioElement.fromJson(e)).toList();

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'elements': elements.map((e) => e.toJson()).toList()
  };
}
