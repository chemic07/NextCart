import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:ecommerce_app/constants/error-handling.dart';
import 'package:ecommerce_app/constants/global_variables.dart';
import 'package:ecommerce_app/constants/utils.dart';
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
      showSnackBar(e.toString(), context);
    }
  }
}
