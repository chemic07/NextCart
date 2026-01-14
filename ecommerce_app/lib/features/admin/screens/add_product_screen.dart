import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:ecommerce_app/constants/global_variables.dart';
import 'package:ecommerce_app/constants/utils.dart';
import 'package:ecommerce_app/features/admin/screens/add_product_text_field.dart';
import 'package:ecommerce_app/features/admin/services/admin_services.dart';
import 'package:ecommerce_app/features/auth/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class AddProductScreen extends StatefulWidget {
  static const routeName = "/add-product";
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final AdminServices adminServices = AdminServices();

  final TextEditingController _productNameController =
      TextEditingController();
  final TextEditingController _descriptionController =
      TextEditingController();
  final TextEditingController _priceController =
      TextEditingController();
  final TextEditingController _quantityController =
      TextEditingController();

  String category = "Mobiles";
  List<File> images = [];
  final _addProductKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  void sellProduct() {
    if (!_addProductKey.currentState!.validate()) return;

    if (images.isEmpty) {
      showSnackBar("Please select product images", context);
      return;
    }

    adminServices.sellProduct(
      context: context,
      name: _productNameController.text,
      description: _descriptionController.text,
      price: double.parse(_priceController.text),
      quantity: double.parse(_quantityController.text),
      category: category,
      images: images,
    );
  }

  @override
  void dispose() {
    _priceController.dispose();
    _productNameController.dispose();
    _descriptionController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  List<String> productCategories = [
    "Mobiles",
    "Essentials",
    "Appliances",
    "Books",
    "Fashion",
  ];

  void selectImages() async {
    var res = await pickImage();
    setState(() {
      images = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),

          title: Text("Add Product"),
          centerTitle: true,
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _addProductKey,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                images.isEmpty
                    ? GestureDetector(
                        onTap: selectImages,
                        child: DottedBorder(
                          options: RectDottedBorderOptions(
                            dashPattern: [10, 4],
                            strokeCap: StrokeCap.round,
                          ),
                          child: Container(
                            width: double.infinity,
                            height: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.center,

                              children: [
                                const Icon(
                                  Icons.folder_open,
                                  size: 40,
                                ),
                                const SizedBox(height: 15),
                                Text(
                                  "Select Product Image",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : CarouselSlider(
                        items: images.map((img) {
                          return Image.file(
                            img,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          );
                        }).toList(),
                        options: CarouselOptions(
                          height: 200,
                          viewportFraction: 1,
                          enlargeCenterPage: false,
                        ),
                      ),

                const SizedBox(height: 20),
                AddProductTextField(
                  hintText: "Product name",
                  controller: _productNameController,
                ),
                const SizedBox(height: 10),
                AddProductTextField(
                  maxLines: 5,
                  hintText: "Description",
                  controller: _descriptionController,
                ),
                const SizedBox(height: 10),
                AddProductTextField(
                  hintText: "Price",
                  controller: _priceController,
                ),
                const SizedBox(height: 10),
                AddProductTextField(
                  hintText: "Quantity",
                  controller: _quantityController,
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: DropdownButtonFormField<String>(
                    initialValue: category,
                    isExpanded: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                    ),
                    items: productCategories.map((String item) {
                      return DropdownMenuItem(
                        value: item,
                        child: Text(item),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        category = value!;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 10),
                CustomButton(text: "Sell", onTap: sellProduct),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
