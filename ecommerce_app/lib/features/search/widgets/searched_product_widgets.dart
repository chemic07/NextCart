import 'package:ecommerce_app/common/widgets/stars.dart';
import 'package:ecommerce_app/features/product-details/screen/product_details_screen.dart';
import 'package:ecommerce_app/models/product.dart';
import 'package:flutter/material.dart';

class SearchedProductWidgets extends StatelessWidget {
  final Product product;

  const SearchedProductWidgets({super.key, required this.product});
  @override
  Widget build(BuildContext context) {
    double totalRating = 0;
    double avgRating = 0;

    if (product.ratings != null && product.ratings!.isNotEmpty) {
      for (var r in product.ratings!) {
        totalRating += r.rating;
      }
      avgRating = totalRating / product.ratings!.length;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 20,
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(
            context,
            ProductDetailsScreen.routeName,
            arguments: product,
          );
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              product.images.first,
              fit: BoxFit.fitHeight,
              height: 135,
              width: 135,
              errorBuilder: (_, __, ___) =>
                  const Icon(Icons.image_not_supported, size: 135),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(fontSize: 16),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 5),
                  Stars(rating: avgRating),
                  const SizedBox(height: 5),
                  Text(
                    '\$${product.price}',
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
    );
  }
}
