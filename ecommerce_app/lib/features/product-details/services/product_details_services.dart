import 'dart:convert';
import 'package:ecommerce_app/constants/error-handling.dart';
import 'package:ecommerce_app/constants/global_variables.dart';
import 'package:ecommerce_app/constants/utils.dart';
import 'package:ecommerce_app/models/cart.dart';
import 'package:ecommerce_app/models/product.dart';
import 'package:ecommerce_app/models/user.dart';
import 'package:ecommerce_app/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class ProductDetailsServices {
  void rateProduct({
    required BuildContext context,
    required Product product,
    required double ratings,
  }) async {
    try {
      final userProvider = Provider.of<UserProvider>(
        context,
        listen: false,
      ).user;

      http.Response res = await http.post(
        Uri.parse("$uri/api/rate-product"),
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
          "Authorization": "Bearer ${userProvider.token}",
        },
        body: jsonEncode({"id": product.id!, "rating": ratings}),
      );

      HttpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {},
      );
    } catch (e) {
      debugPrint(e.toString());
      showSnackBar(e.toString(), context);
    }
  }

  void addToCart({
    required BuildContext context,
    required String productId,
    required int quantity,
  }) async {
    try {
      final userProvider = Provider.of<UserProvider>(
        context,
        listen: false,
      );

      http.Response res = await http.post(
        Uri.parse("$uri/user/add-to-cart"),
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
          "Authorization": "Bearer ${userProvider.user.token}",
        },
        body: jsonEncode({
          "productId": productId,
          "quantity": quantity,
        }),
      );

      HttpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          final decoded = jsonDecode(res.body);
          print(decoded);

          List<Cartitem> cart = List<Cartitem>.from(
            (decoded['cart'] as List).map(
              (x) => Cartitem.fromMap(x as Map<String, dynamic>),
            ),
          );

          User user = userProvider.user.copyWith(cart: cart);
          userProvider.setUsrFromModel(user);

          showSnackBar("Product added to cart", context);
        },
      );
    } catch (e) {
      debugPrint(e.toString());
      showSnackBar(e.toString(), context);
    }
  }
}
