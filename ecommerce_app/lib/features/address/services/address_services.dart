import 'dart:convert';

import 'package:ecommerce_app/constants/error-handling.dart';
import 'package:ecommerce_app/constants/global_variables.dart';
import 'package:ecommerce_app/constants/utils.dart';
import 'package:ecommerce_app/models/user.dart';
import 'package:ecommerce_app/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AddressServices {
  void saveUserAddress({
    required BuildContext context,
    required String address,
  }) async {
    try {
      final userProvider = Provider.of<UserProvider>(
        context,
        listen: false,
      );
      final token = userProvider.user.token;

      final res = await http.post(
        Uri.parse("$uri/user/save-user-address"),
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode({"address": address}),
      );

      HttpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          User user = userProvider.user.copyWith(
            address: jsonDecode(res.body)["address"],
          );

          userProvider.setUsrFromModel(user);
        },
      );
    } catch (e) {
      print(e.toString());
      showSnackBar(e.toString(), context);
    }
  }

  void placeOrder({
    required BuildContext context,
    required String address,
    required double totalSum,
  }) async {
    try {
      final userProvider = Provider.of<UserProvider>(
        context,
        listen: false,
      );
      final token = userProvider.user.token;
      final res = await http.post(
        Uri.parse("$uri/user/place-order"),
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode({
          "cart": userProvider.user.cart
              .map(
                (item) => {
                  "productId": item.product.id,
                  "quantity": item.quantity,
                },
              )
              .toList(),
          "address": address,
          "totalPrice": totalSum,
        }),
      );

      HttpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar("The order has been placed", context);

          User user = userProvider.user.copyWith(cart: []);
          userProvider.setUsrFromModel(user);
        },
      );
    } catch (err) {
      debugPrint(err.toString());
      showSnackBar(err.toString(), context);
    }
  }
}
