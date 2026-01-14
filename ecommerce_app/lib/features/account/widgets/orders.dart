import 'package:ecommerce_app/constants/global_variables.dart';
import 'package:ecommerce_app/features/account/widgets/single_product.dart';
import 'package:flutter/material.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.all(8),
              child: Text(
                "Your Orders",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(8),
              child: Text(
                "See all",
                style: TextStyle(
                  fontSize: 18,
                  color: GlobalVariables.selectedNavBarColor,
                ),
              ),
            ),
          ],
        ),

        Container(
          height: 170,

          padding: EdgeInsets.only(left: 10, top: 20, right: 0),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 3,
            itemBuilder: (context, index) {
              return SingleProduct(
                imageUrl:
                    "https://media.geeksforgeeks.org/wp-content/uploads/20240216084522/bfs-vs-dfs-(1).png",
              );
            },
          ),
        ),
      ],
    );
  }
}
