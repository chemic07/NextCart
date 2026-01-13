import 'package:ecommerce_app/features/widgets/custom_button.dart';
import 'package:ecommerce_app/features/widgets/custom_text_field.dart';
import 'package:ecommerce_app/features/widgets/social_button.dart';
import 'package:flutter/material.dart';

class SigninScreen extends StatefulWidget {
  static const routeName = "/signin-screen";
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController =
      TextEditingController();
  final TextEditingController _passwordController =
      TextEditingController();

  bool _obscurePassword = true;

  void _submit() {
    if (_formKey.currentState!.validate()) {
      // All validations passed
      print("Email: ${_emailController.text}");
      print("Password: ${_passwordController.text}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),

                  const Text(
                    "Welcome Back",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 40),

                  /// Email
                  CustomTextField(
                    hintText: "Username or Email",
                    icon: Icons.person_outline,
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Email is required";
                      }
                      if (!value.contains('@')) {
                        return "Enter a valid email";
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 20),

                  /// Password
                  CustomTextField(
                    hintText: "Password",
                    icon: Icons.lock_outline,
                    isPassword: true,
                    obscureText: _obscurePassword,
                    controller: _passwordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Password is required";
                      }
                      if (value.length < 6) {
                        return "Password must be at least 6 characters";
                      }
                      return null;
                    },
                    onToggleVisibility: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),

                  const SizedBox(height: 12),

                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: const Text("Forgot Password?"),
                    ),
                  ),

                  const SizedBox(height: 30),

                  CustomButton(text: "Signin", onTap: _submit),

                  const SizedBox(height: 30),

                  const Center(child: Text("- OR Continue with -")),
                  const SizedBox(height: 20),

                  /// Social login
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      SocialButton(icon: Icons.g_mobiledata),
                      SizedBox(width: 16),
                      SocialButton(icon: Icons.apple),
                      SizedBox(width: 16),
                      SocialButton(icon: Icons.facebook),
                    ],
                  ),

                  const SizedBox(height: 30),

                  /// Login
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?"),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(" Signup"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
