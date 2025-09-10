import 'package:flutter/material.dart';

class SignupPrompt extends StatelessWidget {
  const SignupPrompt({super.key});

  void _handleSignUp(BuildContext context) {
    Navigator.pushNamed(context, '/signup');
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have an account?"),
        TextButton(
          onPressed: () => _handleSignUp(context),
          child: const Text(
            "Sign Up",
            style: TextStyle(color: Colors.blue),
          ),
        ),
      ],
    );
  }
}