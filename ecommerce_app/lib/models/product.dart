import 'dart:convert';

import 'package:ecommerce_app/models/rating.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Product {
  final String name;
  final String description;
  final double price;
  final List<String> images;
  final String category;
  final double quantity;
  String? id;
  final List<Rating>? ratings;

  Product({
    required this.name,
    required this.description,
    required this.price,
    required this.images,
    required this.category,
    required this.quantity,
    this.id,
    this.ratings,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'description': description,
      'price': price,
      'images': images,
      'category': category,
      'quantity': quantity,
      'id': id,
      'ratings': ratings?.map((x) => x.toMap()).toList(),
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      name: map['name'] as String,
      description: map['description'] as String,
      price: (map['price'] as num).toDouble(),
      images: List<String>.from(map['images'] ?? []),
      category: map['category'] as String,
      quantity: (map['quantity'] as num).toDouble(),
      id: map['_id'],
      ratings: map['ratings'] != null
          ? List<Rating>.from(
              (map['ratings'] as List).map((x) => Rating.fromMap(x)),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Product(name: $name, description: $description, price: $price, images: $images, category: $category, quantity: $quantity, id: $id, ratings: $ratings)';
  }
}
