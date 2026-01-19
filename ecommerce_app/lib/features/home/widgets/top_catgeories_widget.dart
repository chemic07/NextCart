import 'package:ecommerce_app/constants/global_variables.dart';
import 'package:ecommerce_app/features/home/screens/category_deal_screen.dart';
import 'package:flutter/material.dart';

class TopCatgeoriesWidget extends StatelessWidget {
  const TopCatgeoriesWidget({super.key});

  void navigateToCategoryDealScreen(
    BuildContext context,
    String category,
  ) {
    Navigator.pushNamed(
      context,
      CategoryDealScreen.routeName,
      arguments: category,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ListView.builder(
        itemCount: GlobalVariables.categoryImages.length,
        scrollDirection: Axis.horizontal,
        itemExtent: 72,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              navigateToCategoryDealScreen(
                context,
                GlobalVariables.categoryImages[index]["title"]!,
              );
            },
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.asset(
                      GlobalVariables.categoryImages[index]["image"]!,
                      fit: BoxFit.cover,
                      height: 40,
                      width: 40,
                    ),
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  GlobalVariables.categoryImages[index]["title"]!,
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
