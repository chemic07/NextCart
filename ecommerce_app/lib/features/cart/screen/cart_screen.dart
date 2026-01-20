import 'package:ecommerce_app/features/address/screen/address_screen.dart';
import 'package:ecommerce_app/features/auth/widgets/custom_button.dart';
import 'package:ecommerce_app/features/cart/widgets/cart_product_widget.dart';
import 'package:ecommerce_app/features/cart/widgets/cart_sub_total_widget.dart';
import 'package:ecommerce_app/features/home/widgets/address_bar_widget.dart';
import 'package:ecommerce_app/features/home/widgets/home_appbar.dart';
import 'package:ecommerce_app/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;

    num sum = 0;
    for (final e in user.cart) {
      sum += e.quantity * e.product.price;
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: HomeAppbar(),
      ),
      body: ListView(
        children: [
          AddressBarWidget(),
          CartSubTotalWidget(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: CustomButton(
              text: "Proceed to Buy (${user.cart.length})",
              onTap: () {
                Navigator.pushNamed(
                  context,
                  AddressScreen.routeName,
                  arguments: sum.toString(),
                );
              },
              color: const Color.fromARGB(255, 255, 174, 0),
            ),
          ),
          const SizedBox(height: 15),
          Container(height: 1, color: Colors.black12),
          const SizedBox(height: 15),

          // cart items
          ...user.cart.map(
            (item) => CartProductWidget(
              product: item.product,
              quantity: item.quantity,
            ),
          ),
        ],
      ),
    );
  }
}
