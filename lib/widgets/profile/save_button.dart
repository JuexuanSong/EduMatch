import 'package:flutter/material.dart';

class SaveButton extends StatelessWidget {
  final String? errorMessage;
  final VoidCallback onPressed;

  const SaveButton({
    super.key,
    required this.errorMessage,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (errorMessage != null)
          Text(
            errorMessage!,
            style: const TextStyle(color: Colors.red),
          ),
        const SizedBox(height: 16),
        Center(
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00A1DF), // Bright Blue
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Save & Continue',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}