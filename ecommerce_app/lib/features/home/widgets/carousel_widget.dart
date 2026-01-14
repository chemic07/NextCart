import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce_app/constants/global_variables.dart';
import 'package:flutter/material.dart';

class CarouselWidget extends StatelessWidget {
  const CarouselWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: GlobalVariables.carouselImages.map((i) {
        return Image.network(
          i,
          fit: BoxFit.cover,
          width: double.infinity,
        );
      }).toList(),
      options: CarouselOptions(
        height: 200,
        viewportFraction: 1,
        autoPlay: true,
        enlargeCenterPage: false,
      ),
    );
  }
}
