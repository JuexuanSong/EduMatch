import 'package:flutter/material.dart';
import '../widgets/login_form.dart';
import '../widgets/social_login_row.dart';
import '../widgets/remember_and_forgot.dart';
import '../widgets/signup_prompt.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFF6E9D7),
              Color(0xFFE9D9F5),
            ],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Container(
              padding: const EdgeInsets.all(24.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset('assets/logo.png', height: 60),
                  const SizedBox(height: 16),
                  const Text(
                    'Login',
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Enter your email and password to log in',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  const LoginForm(),
                  const SizedBox(height: 12),
                  const RememberAndForgot(),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF3B6EFF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {},
                      child: const Text('Log In'),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const SocialLoginRow(),
                  const SizedBox(height: 16),
                  const SignupPrompt(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
} 
