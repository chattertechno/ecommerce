import 'package:meta/meta.dart';

class Product {
  String id;
  String name;
  String description;
  num price;
  Map<String, dynamic> picture;

  Product({ @required this.id, this.description,
  this.name, this.picture, this.price});

factory Product.fromJson(Map<String, dynamic> json) {
  return Product(
    id: json['id'],
    name: json['name'],
    description: json['description'],
    price: json['price'],
    picture: json['picture']
  );

}

}