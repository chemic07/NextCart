import 'package:ecommerce_app/features/cart/services/cart_services.dart';
import 'package:ecommerce_app/features/product-details/screen/product_details_screen.dart';
import 'package:ecommerce_app/features/product-details/services/product_details_services.dart';
import 'package:ecommerce_app/models/product.dart';
import 'package:flutter/material.dart';

class CartProductWidget extends StatefulWidget {
  final Product product;
  final int quantity;
  const CartProductWidget({
    super.key,
    required this.product,
    required this.quantity,
  });

  @override
  State<CartProductWidget> createState() => _CartProductWidgetState();
}

class _CartProductWidgetState extends State<CartProductWidget> {
  final ProductDetailsServices productDetailsServices =
      ProductDetailsServices();
  final CartServices cartServices = CartServices();

  void decreaseQuantity() {
    cartServices.removeFromCart(
      context: context,
      productId: widget.product.id!,
      quantity: widget.quantity,
    );
  }

  void increaseQuantity() {
    productDetailsServices.addToCart(
      context: context,
      productId: widget.product.id!,
      quantity: widget.quantity,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => Navigator.pushNamed(
              context,
              arguments: widget.product,
              ProductDetailsScreen.routeName,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  widget.product.images.first,
                  fit: BoxFit.cover,
                  height: 135,
                  width: 135,
                  errorBuilder: (_, __, ___) => const Icon(
                    Icons.image_not_supported,
                    size: 135,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.product.name,
                        style: const TextStyle(fontSize: 16),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        '\$${widget.product.price}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Text("Eligible for FREE Shipping"),
                      const SizedBox(height: 5),
                      const Text(
                        "In Stock",
                        style: TextStyle(color: Colors.teal),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black12,
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.black12,
                  ),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: decreaseQuantity,
                        child: Container(
                          width: 35,
                          height: 32,
                          alignment: Alignment.center,
                          child: Icon(Icons.remove),
                        ),
                      ),
                      DecoratedBox(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black12,
                            width: 1.5,
                          ),
                          color: Colors.white,
                        ),
                        child: Container(
                          width: 35,
                          height: 32,
                          alignment: Alignment.center,
                          child: Text(
                            widget.quantity.toString(),
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () => increaseQuantity(),
                        child: Container(
                          width: 35,
                          height: 32,
                          alignment: Alignment.center,
                          child: Icon(Icons.add),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
