import 'package:ecommerce_app/common/widgets/loader.dart';
import 'package:ecommerce_app/constants/global_variables.dart';
import 'package:ecommerce_app/features/home/services/home_services.dart';
import 'package:ecommerce_app/features/product-details/screen/product_details_screen.dart';
import 'package:ecommerce_app/models/product.dart';
import 'package:flutter/material.dart';

class CategoryDealScreen extends StatefulWidget {
  static const String routeName = '/category-deals';
  final String category;
  const CategoryDealScreen({super.key, required this.category});

  @override
  State<CategoryDealScreen> createState() =>
      _CategoryDealScreenState();
}

class _CategoryDealScreenState extends State<CategoryDealScreen> {
  List<Product>? productList;
  final HomeServices homeServices = HomeServices();
  @override
  void initState() {
    super.initState();
    fetchCategoryProducts();
  }

  fetchCategoryProducts() async {
    productList = await homeServices.fetchCategoryProducts(
      context,
      widget.category,
    );
    setState(() {});
  }

  void navigateToProductDetailsScreen(Product product) {
    Navigator.pushNamed(
      context,
      ProductDetailsScreen.routeName,
      arguments: product,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          centerTitle: true,
          title: Text(
            widget.category,
            style: const TextStyle(fontWeight: FontWeight.w400),
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
        ),
      ),
      body: productList == null
          ? const Loader()
          : productList!.isEmpty
          ? Center(
              child: Text(
                'No deals available for ${widget.category}',
              ),
            )
          : Column(
              children: [
                // const SizedBox(height: 10),
                // Center(
                //   child: Text(
                //     'Deals for ${widget.category}',
                //     style: const TextStyle(
                //       fontSize: 20,
                //       fontWeight: FontWeight.w400,
                //     ),
                //   ),
                // ),
                const SizedBox(height: 20),
                Container(
                  height: 170,
                  child: GridView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    itemCount: productList!.length,
                    gridDelegate:
                        SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          childAspectRatio: 1.4,
                          mainAxisSpacing: 10,
                        ),
                    itemBuilder: (context, index) {
                      final product = productList![index];

                      return GestureDetector(
                        onTap: () {
                          navigateToProductDetailsScreen(product);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 6,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              // IMAGE
                              ClipRRect(
                                borderRadius:
                                    const BorderRadius.vertical(
                                      top: Radius.circular(5),
                                    ),
                                child: AspectRatio(
                                  aspectRatio: 1.1,
                                  child: Image.network(
                                    product.images[0],
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) =>
                                        const Center(
                                          child: Icon(
                                            Icons.broken_image,
                                          ),
                                        ),
                                  ),
                                ),
                              ),

                              const SizedBox(height: 6),

                              // PRICE
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                ),
                                child: Text(
                                  '\$${product.price}',
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),

                              // NAME (optional but looks good)
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 2,
                                ),
                                child: Text(
                                  product.name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: Colors.black54,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
