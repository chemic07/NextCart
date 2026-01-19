import 'dart:convert';

import 'package:ecommerce_app/constants/error-handling.dart';
import 'package:ecommerce_app/constants/global_variables.dart';
import 'package:ecommerce_app/constants/utils.dart';
import 'package:ecommerce_app/models/product.dart';
import 'package:ecommerce_app/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class SearchService {
  Future<List<Product>> fetchSearchedProducts(
    BuildContext context,
    String searchQuery,
  ) async {
    List<Product> productList = [];
    try {
      final userProvider = Provider.of<UserProvider>(
        context,
        listen: false,
      );

      final token = userProvider.user.token;

      http.Response res = await http.get(
        Uri.parse("$uri/api/products/search/$searchQuery"),
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
      showSnackBar("Failed to fetch searched products", context);
    }
    return productList;
  }
}
