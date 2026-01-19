// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:ecommerce_app/models/product.dart';

class Cartitem {
  final Product product;
  final int quantity;

  Cartitem({required this.product, required this.quantity});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'product': product.toMap(),
      'quantity': quantity,
    };
  }

  factory Cartitem.fromMap(Map<String, dynamic> map) {
    return Cartitem(
      product: Product.fromMap(
        map['product'] as Map<String, dynamic>,
      ),
      quantity: map['quantity'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Cartitem.fromJson(String source) =>
      Cartitem.fromMap(json.decode(source) as Map<String, dynamic>);
}
