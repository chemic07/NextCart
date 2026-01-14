import 'package:ecommerce_app/features/account/widgets/account_button.dart';
import 'package:flutter/material.dart';

class TopButtons extends StatelessWidget {
  const TopButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AccountButton(onTap: () {}, text: "Your Order"),
            AccountButton(onTap: () {}, text: "Turn seller"),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AccountButton(onTap: () {}, text: "Log Out"),
            AccountButton(onTap: () {}, text: "Your Wish List"),
          ],
        ),
      ],
    );
  }
}
