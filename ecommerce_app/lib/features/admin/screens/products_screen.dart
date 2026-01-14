import 'package:ecommerce_app/features/admin/screens/add_product_screen.dart';
import 'package:flutter/material.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  void navigateToAddproduct() {
    Navigator.pushNamed(context, AddProductScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(child: Text("Products")),
      floatingActionButton: FloatingActionButton(
        onPressed: navigateToAddproduct,
        tooltip: "Add Products",
        backgroundColor: const Color.fromARGB(255, 1, 145, 148),
        shape: const CircleBorder(), // makes it perfectly round
        child: const Icon(Icons.add, size: 30),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.centerFloat,
    );
  }
}
