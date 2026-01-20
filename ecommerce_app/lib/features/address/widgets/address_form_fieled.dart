import 'package:flutter/material.dart';

class AddressFormFieled extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;

  const AddressFormFieled({
    super.key,
    required this.hintText,
    this.controller,
  });
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,

      decoration: InputDecoration(
        hintText: hintText,
        enabledBorder: _border(),
        focusedBorder: _border(color: Colors.blue),
        errorBorder: _border(color: Colors.red),
        focusedErrorBorder: _border(color: Colors.red),
      ),
    );
  }

  OutlineInputBorder _border({Color color = Colors.grey}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: color),
    );
  }
}
