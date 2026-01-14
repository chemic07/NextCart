import 'package:ecommerce_app/constants/global_variables.dart';
import 'package:flutter/material.dart';

class CustomAdminAppbar extends StatelessWidget {
  const CustomAdminAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 2,
      ),
      decoration: const BoxDecoration(
        gradient: GlobalVariables.appBarGradient,
      ),
      child: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Top Row
            Row(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 5),
                  child: Image.asset(
                    "assets/images/amazon_in.png",
                    width: 120,
                    height: 40,
                    color: Colors.black,
                  ),
                ),
                const Spacer(),
                Text(
                  "Admin",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
