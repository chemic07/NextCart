import 'package:ecommerce_app/features/auth/screens/signin_screen.dart';
import 'package:ecommerce_app/features/auth/services/auth_service.dart';
import 'package:ecommerce_app/features/auth/widgets/custom_button.dart';
import 'package:ecommerce_app/features/auth/widgets/custom_text_field.dart';
import 'package:ecommerce_app/features/auth/widgets/social_button.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  static const routeName = "/signup-screen";
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final AuthService authService = AuthService();
  final TextEditingController _nameController =
      TextEditingController();
  final TextEditingController _emailController =
      TextEditingController();
  final TextEditingController _passwordController =
      TextEditingController();

  bool _obscurePassword = true;

  void _signUpUser() {
    if (_formKey.currentState!.validate()) {
      authService.signUpUser(
        name: _nameController.text,
        email: _emailController.text,
        password: _passwordController.text,
        context: context,
      );
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),

                /// Title
                const Text(
                  "Create\nAccount",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 40),

                /// FORM
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      /// Name
                      CustomTextField(
                        hintText: "Full Name",
                        icon: Icons.person_outline,
                        controller: _nameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Full name is required";
                          }
                          if (value.length < 3) {
                            return "Name must be at least 3 characters";
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 20),

                      /// Email
                      CustomTextField(
                        hintText: "Email Address",
                        icon: Icons.email_outlined,
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

                      const SizedBox(height: 30),

                      /// Create Account Button
                      CustomButton(
                        text: "Create Account",
                        onTap: _signUpUser,
                      ),
                    ],
                  ),
                ),

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
                    const Text("Already have an account?"),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SigninScreen(),
                          ),
                        );
                      },
                      child: const Text(" Login"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
