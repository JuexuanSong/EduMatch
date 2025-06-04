import 'package:flutter/material.dart';

/// This widget displays a row of social login icons
class SocialLoginRow extends StatelessWidget {
  const SocialLoginRow({super.key});

  Widget _buildIcon(IconData icon) {
    return CircleAvatar(
      radius: 22,
      backgroundColor: Colors.grey.shade200,
      child: Icon(icon, color: Colors.black),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: const [
            Expanded(child: Divider()),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Text("Or login with"),
            ),
            Expanded(child: Divider()),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildIcon(Icons.g_mobiledata), // Google icon
            _buildIcon(Icons.facebook), // Facebook icon
            _buildIcon(Icons.apple), // Apple icon
            _buildIcon(Icons.smartphone), // Phone icon
          ],
        ),
      ],
    );
  }
}
