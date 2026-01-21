class OrderProduct {
  final String productId;
  final String name;
  final String image;
  final int quantity;
  final double priceAtPurchase;

  OrderProduct({
    required this.productId,
    required this.name,
    required this.image,
    required this.quantity,
    required this.priceAtPurchase,
  });

  factory OrderProduct.fromMap(Map<String, dynamic> map) {
    return OrderProduct(
      productId: map['productId'],
      name: map['name'],
      image: map['image'],
      quantity: map['quantity'],
      priceAtPurchase: (map['priceAtPurchase'] as num).toDouble(),
    );
  }
}
