import 'dart:convert';

class BasketModel {
  String name;
  String price;
  String image;
  int id;
  BasketModel({
    required this.name,
    required this.price,
    required this.image,
    required this.id,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'image': image,
      'id': id,
    };
  }

  factory BasketModel.fromMap(Map<String, dynamic> map) {
    return BasketModel(
      name: map['name'] ?? '',
      price: map['price'] ?? '',
      image: map['image'] ?? '',
      id: map['id'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory BasketModel.fromJson(String source) =>
      BasketModel.fromMap(json.decode(source));
}
