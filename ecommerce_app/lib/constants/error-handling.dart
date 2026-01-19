import "dart:convert";

import "package:ecommerce_app/constants/utils.dart";
import "package:flutter/material.dart";
import "package:http/http.dart" as http;

void HttpErrorHandle({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess,
}) {
  switch (response.statusCode) {
    case 200 || 201:
      onSuccess();
      break;
    case 400:
      showSnackBar(jsonDecode(response.body)['message'], context);
      break;
    case 500:
      showSnackBar(jsonDecode(response.body)['error'], context);
      break;
    default:
      showSnackBar(response.body, context);
  }
}
