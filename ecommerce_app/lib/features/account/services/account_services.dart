import 'dart:convert';

import 'package:ecommerce_app/constants/error-handling.dart';
import 'package:ecommerce_app/constants/global_variables.dart';
import 'package:ecommerce_app/constants/utils.dart';
import 'package:ecommerce_app/features/auth/screens/signup_screen.dart';
import 'package:ecommerce_app/models/order.dart';
import 'package:ecommerce_app/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AccountServices {
  Future<List<Order>> getOrders(BuildContext context) async {
    List<Order> orders = [];

    try {
      final userProvider = Provider.of<UserProvider>(
        context,
        listen: false,
      );
      final token = userProvider.user.token;

      http.Response res = await http.get(
        Uri.parse("$uri/user/orders/me"),
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
          "Authorization": "Bearer $token",
        },
      );

      print(res.body);
      HttpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          final List data = jsonDecode(res.body);

          orders = data.map((e) => Order.fromMap(e)).toList();
        },
      );
    } catch (e) {
      print("**********");
      showSnackBar(e.toString(), context);
    }

    return orders;
  }

  void logOut({required BuildContext context}) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      await prefs.setString("x-auth-token", "");
      Navigator.pushNamedAndRemoveUntil(
        context,
        SignupScreen.routeName,
        (route) => false,
      );
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
  }
}
