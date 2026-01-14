import 'package:ecommerce_app/constants/global_variables.dart';
import 'package:flutter/material.dart';

class BelowAppbar extends StatefulWidget {
  const BelowAppbar({super.key});

  @override
  State<BelowAppbar> createState() => _BelowAppbarState();
}

class _BelowAppbarState extends State<BelowAppbar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: GlobalVariables.appBarGradient,
      ),
      child: RichText(text: TextSpan(text: "Hello")),
    );
  }
}
