import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce_app/common/widgets/stars.dart';
import 'package:ecommerce_app/constants/global_variables.dart';
import 'package:ecommerce_app/constants/utils.dart';
import 'package:ecommerce_app/features/auth/widgets/custom_button.dart';
import 'package:ecommerce_app/features/product-details/services/product_details_services.dart';
import 'package:ecommerce_app/features/search/screen/search_screen.dart';
import 'package:ecommerce_app/models/product.dart';
import 'package:ecommerce_app/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class ProductDetailsScreen extends StatefulWidget {
  static const String routeName = '/product-details-screen';
  final Product product;
  const ProductDetailsScreen({super.key, required this.product});

  @override
  State<ProductDetailsScreen> createState() =>
      _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final ProductDetailsServices productDetailsServices =
      ProductDetailsServices();
  double avgRating = 0;
  double userRating = 0;
  @override
  void initState() {
    super.initState();
    double totalRating = 0;
    for (int i = 0; i < widget.product.ratings!.length; i++) {
      totalRating += widget.product.ratings![i].rating;
      if (widget.product.ratings![i].userId ==
          Provider.of<UserProvider>(context, listen: false).user.id) {
        userRating = widget.product.ratings![i].rating;
      }
    }

    if (totalRating != 0) {
      avgRating = totalRating / widget.product.ratings!.length;
    }
  }

  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(
      context,
      SearchScreen.routeName,
      arguments: query,
    );
  }

  void addToCart() {
    productDetailsServices.addToCart(
      context: context,
      productId: widget.product.id!,
      quantity: 1,
    );
    showSnackBar("Product added to cart", context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 42,
                  child: Material(
                    borderRadius: BorderRadius.circular(7),
                    elevation: 1,
                    child: TextFormField(
                      onFieldSubmitted: navigateToSearchScreen,
                      decoration: InputDecoration(
                        prefixIcon: InkWell(
                          onTap: () {},
                          child: const Padding(
                            padding: EdgeInsets.only(left: 6),
                            child: Icon(
                              Icons.search,
                              color: Colors.black,
                              size: 23,
                            ),
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.only(
                          top: 10,
                        ),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(7),
                          ),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(7),
                          ),
                          borderSide: BorderSide(
                            color: Colors.black38,
                            width: 1,
                          ),
                        ),
                        hintText: 'Search Amazon.in',
                        hintStyle: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              const Icon(Icons.mic, color: Colors.black, size: 25),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.product.id!),
                  Stars(rating: avgRating),
                ],
              ),
            ),
            //name
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.product.name,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            CarouselSlider(
              items: widget.product.images.map((i) {
                return Image.network(
                  i,
                  fit: BoxFit.cover,
                  width: double.infinity,
                );
              }).toList(),
              options: CarouselOptions(
                height: 300,
                viewportFraction: 1,
                enlargeCenterPage: true,
              ),
            ),
            Container(height: 5, color: Colors.black12),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RichText(
                text: TextSpan(
                  text: 'Deal Price: ',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                  children: [
                    TextSpan(
                      text: '\$${widget.product.price}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(widget.product.description),
            ),
            // Product description
            // Add to cart button
            // Other product details
            Container(height: 5, color: Colors.black12),

            Padding(
              padding: const EdgeInsets.all(10.0),
              child: CustomButton(
                text: "BUY NOW",
                onTap: () {},
                color: const Color.fromARGB(255, 255, 179, 0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: CustomButton(
                text: "ADD TO CART",
                onTap: addToCart,
                color: Colors.orange,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Rate this product",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            RatingBar.builder(
              initialRating: userRating,
              itemSize: 30,
              itemBuilder: (context, index) =>
                  const Icon(Icons.star, color: Colors.orange),
              onRatingUpdate: (rating) {
                productDetailsServices.rateProduct(
                  context: context,
                  product: widget.product,
                  ratings: rating,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
