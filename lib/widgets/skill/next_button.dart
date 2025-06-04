import 'package:flutter/material.dart';

class NextButton extends StatelessWidget {
  final List<Map<String, dynamic>> skills;
  final Function(List<String>) onPressed;

  const NextButton({
    super.key,
    required this.skills,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final hasSelection = skills.any((skill) => skill['selected']);
    return Align(
      alignment: Alignment.bottomRight,
      child: ElevatedButton(
        onPressed: hasSelection
            ? () {
                final selectedSkills = skills
                    .where((skill) => skill['selected'])
                    .map((skill) => skill['name'] as String)
                    .toList();
                onPressed(selectedSkills);
              }
            : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF00A1DF), // Bright Blue
          disabledBackgroundColor: const Color(0xFFDCD4C4), // Light Grey
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text(
          'Next',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}