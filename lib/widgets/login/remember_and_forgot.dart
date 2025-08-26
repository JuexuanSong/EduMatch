import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RememberAndForgot extends StatefulWidget {
  final Function(bool)? onRememberMeChanged;

  const RememberAndForgot({super.key, this.onRememberMeChanged});

  @override
  State<RememberAndForgot> createState() => _RememberAndForgotState();
}

class _RememberAndForgotState extends State<RememberAndForgot> {
  bool rememberMe = false;

  @override
  void initState() {
    super.initState();
    _loadRememberMe();
  }

  Future<void> _loadRememberMe() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      rememberMe = prefs.getBool('remember_me') ?? false;
    });
  }

  Future<void> _saveRememberMe(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('remember_me', value);
  }

  void _handleForgotPassword() {
    Navigator.pushNamed(context, '/forgot-password');
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Checkbox(
              value: rememberMe,
              onChanged: (val) {
                setState(() {
                  rememberMe = val!;
                });
                _saveRememberMe(val!);
                widget.onRememberMeChanged?.call(val);
              },
            ),
            const Text("Remember me"),
          ],
        ),
        TextButton(
          onPressed: _handleForgotPassword,
          child: const Text(
            "Forgot Password?",
            style: TextStyle(color: Colors.blue),
          ),
        ),
      ],
    );
  }
}