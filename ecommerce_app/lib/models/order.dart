import 'dart:convert';

import 'package:ecommerce_app/models/order_product.dart';

class Order {
  final String id;
  final List<OrderProduct> products;
  final double totalPrice;
  final String address;
  final int status;
  final String userId;
  final DateTime orderedAt;

  Order({
    required this.id,
    required this.products,
    required this.totalPrice,
    required this.address,
    required this.status,
    required this.userId,
    required this.orderedAt,
  });

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['_id'],
      products: List<OrderProduct>.from(
        (map['products'] as List).map((x) => OrderProduct.fromMap(x)),
      ),
      totalPrice: (map['totalPrice'] as num).toDouble(),
      address: map['address'],
      status: map['status'],
      userId: map['userId'],
      orderedAt: DateTime.parse(map['orderedAt']),
    );
  }

  factory Order.fromJson(String source) =>
      Order.fromMap(json.decode(source));
}
