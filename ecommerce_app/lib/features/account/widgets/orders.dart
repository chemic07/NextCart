import 'package:ecommerce_app/constants/global_variables.dart';
import 'package:ecommerce_app/features/account/services/account_services.dart';
import 'package:ecommerce_app/features/account/widgets/single_product.dart';
import 'package:ecommerce_app/features/order_details/screen/order_details.dart';
import 'package:ecommerce_app/models/order.dart';
import 'package:flutter/material.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  List<Order>? orderes;
  final AccountServices accountServices = AccountServices();
  @override
  void initState() {
    super.initState();
    fetchOrder();
  }

  void fetchOrder() async {
    orderes = await accountServices.getOrders(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (orderes == null) {
      return const Center(child: CircularProgressIndicator());
    }

    if (orderes!.isEmpty) {
      return const Text("No Order found");
    }

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                "Your Orders",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
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
          padding: const EdgeInsets.only(left: 10, top: 20),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: orderes!.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 3),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      OrderDetails.routeName,
                      arguments: orderes![index],
                    );
                  },
                  child: SingleProduct(
                    imageUrl: orderes![index].products[0].image,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
