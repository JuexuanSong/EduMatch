import 'package:flutter/material.dart';

class AvatarSection extends StatelessWidget {
  const AvatarSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Photo upload feature coming soon!')),
              );
            },
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.person_add,
                size: 50,
                color: Colors.grey,
              ),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Upload your photo',
            style: TextStyle(color: Color(0xFF00487B)), // Dark Navy
          ),
        ],
      ),
    );
  }
}