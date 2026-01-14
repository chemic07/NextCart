import 'package:ecommerce_app/constants/global_variables.dart';
import 'package:ecommerce_app/features/home/widgets/search_bar.dart';
import 'package:flutter/material.dart';

class HomeAppbar extends StatefulWidget {
  const HomeAppbar({super.key});

  @override
  State<HomeAppbar> createState() => _HomeAppbarState();
}

class _HomeAppbarState extends State<HomeAppbar> {
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
            SizedBox(height: 15),
            Container(
              child: Row(
                children: [
                  SearchBarWidget(),
                  SizedBox(width: 10),
                  Icon(Icons.mic, color: Colors.black),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
