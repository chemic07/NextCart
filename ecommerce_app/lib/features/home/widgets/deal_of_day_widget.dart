import 'package:ecommerce_app/common/widgets/loader.dart';
import 'package:ecommerce_app/features/home/services/home_services.dart';
import 'package:ecommerce_app/models/product.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/features/product-details/screen/product_details_screen.dart';

class DealOfDayWidget extends StatefulWidget {
  const DealOfDayWidget({super.key});

  @override
  State<DealOfDayWidget> createState() => _DealOfDayWidgetState();
}

class _DealOfDayWidgetState extends State<DealOfDayWidget> {
  final HomeServices homeServices = HomeServices();
  Product? product;
  @override
  void initState() {
    super.initState();
    getDealOfDay();
  }

  void getDealOfDay() async {
    product = await homeServices.fetchDealOfDay(context);
    setState(() {});
  }

  void navigateToDetailScreen() {
    Navigator.pushNamed(
      context,
      ProductDetailsScreen.routeName,
      arguments: product,
    );
  }

  @override
  Widget build(BuildContext context) {
    return product == null
        ? Loader()
        : product!.name.isEmpty
        ? const SizedBox()
        : GestureDetector(
            onTap: navigateToDetailScreen,
            child: Column(
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    "Deal of the day",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Image.network(
                  product!.images[1],
                  height: 223,
                  fit: BoxFit.fitHeight,
                ),

                Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.only(left: 15),
                  child: Text(
                    "\$${product!.price}",
                    style: TextStyle(fontSize: 18),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.only(
                    left: 15,
                    top: 5,
                    right: 40,
                  ),
                  child: Text(
                    product!.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: product!.images
                        .map(
                          (image) => Image.network(
                            image,
                            fit: BoxFit.cover,
                            width: 70,
                            height: 70,
                          ),
                        )
                        .toList(),
                  ),
                ),

                Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: const Text(
                    "See all deals",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.cyan),
                  ),
                ),
              ],
            ),
          );
  }
}
