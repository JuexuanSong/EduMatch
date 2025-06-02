import 'package:flutter/material.dart';

class SignupPrompt extends StatelessWidget {
  const SignupPrompt({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have an account?"),
        TextButton(
          onPressed: () {},
          child: const Text("Sign Up", style: TextStyle(color: Colors.blue)),
        ),
      ],
    );
  }
}
