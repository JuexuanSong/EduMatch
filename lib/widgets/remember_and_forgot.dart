import 'package:flutter/material.dart';

class RememberAndForgot extends StatefulWidget {
  const RememberAndForgot({super.key});

  @override
  State<RememberAndForgot> createState() => _RememberAndForgotState();
}

class _RememberAndForgotState extends State<RememberAndForgot> {
  bool rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Checkbox(
              value: rememberMe,
              onChanged: (val) => setState(() => rememberMe = val!),
            ),
            const Text("Remember me"),
          ],
        ),
        TextButton(
          onPressed: () {},
          child: const Text("Forgot Password ?", style: TextStyle(color: Colors.blue)),
        ),
      ],
    );
  }
}
