import 'dart:convert';

import 'package:ecommerce_app/constants/error-handling.dart';
import 'package:ecommerce_app/constants/global_variables.dart';
import 'package:ecommerce_app/constants/utils.dart';
import 'package:ecommerce_app/models/product.dart';
import 'package:ecommerce_app/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class HomeServices {
  Future<List<Product>> fetchCategoryProducts(
    BuildContext context,
    String category,
  ) async {
    List<Product> productList = [];
    try {
      final userProvider = Provider.of<UserProvider>(
        context,
        listen: false,
      );

      final token = userProvider.user.token;

      http.Response res = await http.get(
        Uri.parse("$uri/api/products?category=$category"),
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
          "Authorization": "Bearer $token",
        },
      );

      HttpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            productList.add(
              Product.fromJson(jsonEncode(jsonDecode(res.body)[i])),
            );
          }
        },
      );
    } catch (e) {
      showSnackBar("Failed to fetch catgoy products", context);
    }
    return productList;
  }

  Future<Product> fetchDealOfDay(BuildContext context) async {
    Product product = Product(
      name: '',
      description: '',
      price: 0,
      images: [],
      category: '',
      quantity: 0,
      ratings: [],
    );
    try {
      final userProvider = Provider.of<UserProvider>(
        context,
        listen: false,
      );

      final token = userProvider.user.token;

      http.Response res = await http.get(
        Uri.parse("$uri/api/deal-of-day"),
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
          "Authorization": "Bearer $token",
        },
      );

      HttpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          product = Product.fromJson(res.body);
        },
      );
    } catch (e) {
      debugPrint(e.toString());
      showSnackBar("Failed to fetch deal of the day", context);
    }
    return product;
  }
}
