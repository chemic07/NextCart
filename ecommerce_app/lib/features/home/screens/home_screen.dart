import 'package:ecommerce_app/features/home/widgets/address_bar_widget.dart';
import 'package:ecommerce_app/features/home/widgets/carousel_widget.dart';
import 'package:ecommerce_app/features/home/widgets/deal_of_day_widget.dart';
import 'package:ecommerce_app/features/home/widgets/home_appbar.dart';
import 'package:ecommerce_app/features/home/widgets/top_catgeories_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "/home";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, '/search-screen', arguments: query);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: HomeAppbar(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AddressBarWidget(),
            SizedBox(height: 10),
            TopCatgeoriesWidget(),
            SizedBox(height: 10),
            CarouselWidget(),
            SizedBox(height: 10),
            DealOfDayWidget(),
          ],
        ),
      ),
    );
  }
}
