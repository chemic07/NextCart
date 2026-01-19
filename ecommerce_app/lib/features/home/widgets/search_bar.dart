import 'package:ecommerce_app/features/search/screen/search_screen.dart';
import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  void navigateToSearchScreen(BuildContext context, String query) {
    Navigator.pushNamed(
      context,
      SearchScreen.routeName,
      arguments: query,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextFormField(
        onFieldSubmitted: (value) {
          if (value.trim().isEmpty) return;
          navigateToSearchScreen(context, value);
        },
        decoration: InputDecoration(
          hintText: 'Search Amazon.in',
          prefixIcon: const Icon(Icons.search, color: Colors.black54),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(vertical: 0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.black12),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: Colors.teal,
              width: 2,
            ),
          ),
        ),
      ),
    );
  }
}
