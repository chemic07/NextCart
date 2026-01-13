import 'package:ecommerce_app/common/widgets/bottom_bar.dart';
import 'package:ecommerce_app/features/auth/services/auth_service.dart';
import 'package:ecommerce_app/provider/user_provider.dart';
import 'package:ecommerce_app/theme/theme.dart';
import 'package:ecommerce_app/features/auth/screens/signup_screen.dart';
import 'package:ecommerce_app/router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      authService.getUserData(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    if (userProvider.isLoading) {
      return const MaterialApp(
        home: Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
      );
    }
    return MaterialApp(
      title: "Ecommerce App",
      debugShowCheckedModeBanner: false,
      darkTheme: AppTheme.darkTheme(),
      home: userProvider.user.token.isEmpty
          ? SignupScreen()
          : BottomBar(),
      onGenerateRoute: generateRoute,
    );
  }
}
