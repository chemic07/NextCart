import 'dart:convert';

import 'package:ecommerce_app/constants/error-handling.dart';
import 'package:ecommerce_app/constants/global_variables.dart';
import 'package:ecommerce_app/constants/utils.dart';
import 'package:ecommerce_app/models/cart.dart';
import 'package:ecommerce_app/models/user.dart';
import 'package:ecommerce_app/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class CartServices {
  void removeFromCart({
    required BuildContext context,
    required String productId,
    required int quantity,
  }) async {
    try {
      final userProvider = Provider.of<UserProvider>(
        context,
        listen: false,
      );

      http.Response res = await http.delete(
        Uri.parse("$uri/user/remove-from-cart/$productId"),
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
          "Authorization": "Bearer ${userProvider.user.token}",
        },
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
        },
      );
    } catch (e) {
      debugPrint(e.toString());
      showSnackBar(e.toString(), context);
    }
  }
}
