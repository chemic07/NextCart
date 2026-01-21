import 'dart:convert';
import 'package:ecommerce_app/common/widgets/bottom_bar.dart';
import 'package:ecommerce_app/constants/error-handling.dart';
import 'package:ecommerce_app/constants/global_variables.dart';
import 'package:ecommerce_app/constants/utils.dart';
import 'package:ecommerce_app/features/auth/screens/signin_screen.dart';
import 'package:ecommerce_app/models/user.dart';
import 'package:ecommerce_app/provider/user_provider.dart';
import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  void signUpUser({
    required String name,
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      User user = User(
        id: "",
        email: email,
        name: name,
        password: password,
        address: "",
        type: "",
        token: "",
        cart: [],
      );

      http.Response res = await http.post(
        Uri.parse("$uri/api/signup"),
        body: user.toJson(),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
        },
      );

      HttpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(
            "Account Created! Login with the same credentials",
            context,
          );
          Navigator.pushNamed(context, SigninScreen.routeName);
        },
      );
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
  }

  void signInUser({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse("$uri/api/login"),
        body: jsonEncode({"email": email, "password": password}),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
        },
      );

      HttpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          //storing user data in local memory
          SharedPreferences prefs =
              await SharedPreferences.getInstance();

          await prefs.setString(
            "x-auth-token",
            jsonDecode(res.body)["token"],
          );

          // storing user in provider
          print("************");
          print(res.body);
          Provider.of<UserProvider>(
            context,
            listen: false,
          ).setUser(res.body);
          //navigate
          Navigator.popAndPushNamed(context, BottomBar.routeName);
          print("************");
        },
      );
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
  }

  void getUserData(BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("x-auth-token");

      debugPrint("TOKEN FROM STORAGE: $token");

      // if not token
      if (token == null || token.isEmpty) {
        Provider.of<UserProvider>(
          context,
          listen: false,
        ).setLoading(false);
        return;
      }

      // token validate with the above token
      final tokenRes = await http.get(
        Uri.parse("$uri/api/token/validate"),
        headers: {'Authorization': 'Bearer $token'},
      );

      final isValid = jsonDecode(tokenRes.body)["valid"];

      // if not valid
      if (!isValid) {
        await prefs.remove("x-auth-token");
        Provider.of<UserProvider>(
          context,
          listen: false,
        ).setLoading(false);
        return;
      }

      // check if its me
      final userRes = await http.get(
        Uri.parse("$uri/me"),
        headers: {'Authorization': 'Bearer $token'},
      );

      Provider.of<UserProvider>(
        context,
        listen: false,
      ).setUser(userRes.body);
    } catch (e) {
      debugPrint(e.toString());

      Provider.of<UserProvider>(
        context,
        listen: false,
      ).setLoading(false);
    }
  }
}
