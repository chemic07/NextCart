import 'dart:convert';
import 'dart:io';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:ecommerce_app/constants/error-handling.dart';
import 'package:ecommerce_app/constants/global_variables.dart';
import 'package:ecommerce_app/constants/utils.dart';
import 'package:ecommerce_app/models/order.dart';
import 'package:ecommerce_app/models/product.dart';
import 'package:ecommerce_app/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AdminServices {
  void sellProduct({
    required BuildContext context,
    required String name,
    required String description,
    required double price,
    required double quantity,
    required String category,
    required List<File> images,
  }) async {
    try {
      final userProvider = Provider.of<UserProvider>(
        context,
        listen: false,
      );
      final token = userProvider.user.token;

      final cloudinary = CloudinaryPublic("dmmn9tu86", "upload");
      List<String> imageUrl = [];

      for (final image in images) {
        final res = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(image.path, folder: "products"),
        );
        imageUrl.add(res.secureUrl);
      }

      final product = Product(
        name: name,
        description: description,
        price: price,
        images: imageUrl,
        category: category,
        quantity: quantity,
      );

      final res = await http.post(
        Uri.parse("$uri/admin/add-product"),
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
          "Authorization": "Bearer $token",
        },
        body: product.toJson(),
      );

      HttpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar("Product Added Successfully", context);
          Navigator.pop(context);
        },
      );
    } catch (e) {
      print(e.toString());
      showSnackBar(e.toString(), context);
    }
  }

  Future<List<Product>> fetchAllProducts(BuildContext context) async {
    List<Product> productList = [];
    try {
      final userProvider = Provider.of<UserProvider>(
        context,
        listen: false,
      );

      final token = userProvider.user.token;

      http.Response res = await http.get(
        Uri.parse("$uri/admin/get-products"),
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
          "Authorization": "Bearer $token",
        },
      );

      // final List decoded = jsonDecode(res.body);
      HttpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            productList.add(
              Product.fromJson(jsonEncode(jsonDecode(res.body)[i])),
            );
            // productList.add(Product.fromMap(decoded[i]));
          }
        },
      );
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
    return productList;
  }

  void deletProductById({
    required BuildContext context,
    required String productId,
    required VoidCallback onSuccess,
  }) async {
    try {
      final userProvider = Provider.of<UserProvider>(
        context,
        listen: false,
      );

      final token = userProvider.user.token;

      http.Response res = await http.delete(
        Uri.parse("$uri/admin/delete-product/$productId"),
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
          "Authorization": "Bearer $token",
        },
      );

      HttpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          onSuccess();
        },
      );
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
  }

  Future<List<Order>> fetchOrders(BuildContext context) async {
    List<Order> orderList = [];
    try {
      final userProvider = Provider.of<UserProvider>(
        context,
        listen: false,
      );

      final token = userProvider.user.token;

      http.Response res = await http.get(
        Uri.parse("$uri/admin/get-orders"),
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
          "Authorization": "Bearer $token",
        },
      );

      HttpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          final List data = jsonDecode(res.body);
          orderList = data.map((e) => Order.fromMap(e)).toList();
        },
      );
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
    return orderList;
  }

  void changeOrderStatus({
    required BuildContext context,
    required Order order,
    required int status,
    required VoidCallback onSuccess,
  }) async {
    try {
      final userProvider = Provider.of<UserProvider>(
        context,
        listen: false,
      );
      final token = userProvider.user.token;

      final res = await http.patch(
        Uri.parse("$uri/admin/order/update-status"),
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode({"orderId": order.id, "status": status}),
      );

      HttpErrorHandle(
        response: res,
        context: context,
        onSuccess: onSuccess,
      );
      print(res.body);
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
  }
}
