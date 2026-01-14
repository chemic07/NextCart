import 'package:ecommerce_app/features/account/widgets/custom_app_bar.dart';
import 'package:ecommerce_app/features/account/widgets/orders.dart';
import 'package:ecommerce_app/features/account/widgets/top_buttons.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(95),
        child: CustomAppBar(),
      ),
      body: Column(children: [TopButtons(), Orders()]),
    );
  }
}
