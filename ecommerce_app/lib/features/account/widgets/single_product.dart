import 'package:flutter/material.dart';

class SingleProduct extends StatelessWidget {
  final String imageUrl;

  const SingleProduct({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      width: 180,
      height: 160,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.black12),
      ),
      child: Center(
        child: Image.network(imageUrl, fit: BoxFit.cover),
      ),
    );
  }
}
