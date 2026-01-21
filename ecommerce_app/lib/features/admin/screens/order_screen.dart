import 'package:ecommerce_app/common/widgets/loader.dart';
import 'package:ecommerce_app/features/account/widgets/single_product.dart';
import 'package:ecommerce_app/features/admin/services/admin_services.dart';
import 'package:ecommerce_app/features/order_details/screen/order_details.dart';
import 'package:ecommerce_app/models/order.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final AdminServices adminServices = AdminServices();
  List<Order>? orders;

  @override
  void initState() {
    super.initState();
    getOrders();
  }

  void getOrders() async {
    orders = await adminServices.fetchOrders(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return orders == null
        ? const Loader()
        : orders!.length == 0
        ? const Center(child: Text("No orders"))
        : GridView.builder(
            itemCount: orders!.length,
            gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
            itemBuilder: (context, index) {
              final orderData = orders![index];

              return Padding(
                padding: const EdgeInsets.all(5.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      OrderDetails.routeName,
                      arguments: orderData,
                    );
                  },
                  child: SizedBox(
                    height: 140,
                    child: SingleProduct(
                      imageUrl: orderData.products[0].image,
                    ),
                  ),
                ),
              );
            },
          );
  }
}
