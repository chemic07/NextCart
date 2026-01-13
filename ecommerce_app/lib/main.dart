import 'package:ecommerce_app/constants/theme.dart';
import 'package:ecommerce_app/features/screens/signin_screen.dart';
import 'package:ecommerce_app/features/screens/signup_screen.dart';
import 'package:ecommerce_app/home_page.dart';
import 'package:ecommerce_app/router.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Ecommerce App",
      debugShowCheckedModeBanner: false,
      darkTheme: AppTheme.darkTheme(),
      home: SignupScreen(),
      onGenerateRoute: (settings) => generateRoute(settings),
    );
  }
}
