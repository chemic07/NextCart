import 'package:ecommerce_app/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartSubTotalWidget extends StatelessWidget {
  const CartSubTotalWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;

    num sum = 0;
    for (final e in user.cart) {
      sum += e.quantity * e.product.price;
    }

    return Container(
      margin: EdgeInsets.all(10),
      child: Row(
        children: [
          Text("Subtotal ", style: TextStyle(fontSize: 20)),
          Text(
            "\$$sum",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
