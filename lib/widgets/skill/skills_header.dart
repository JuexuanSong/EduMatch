import 'package:flutter/material.dart';

class SkillsHeader extends StatelessWidget {
  final int selectedCount;
  final int totalCount;
  final String title;
  final String subtitle;
  
  const SkillsHeader({
    super.key,
    this.selectedCount = 0,
    this.totalCount = 0,
    this.title = 'What do you wanna learn about?',
    this.subtitle = 'Select at least one subject you\'re interested in learning.',
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          subtitle,
          style: const TextStyle(
            fontSize: 16,
            color: Color(0xFF00487B),
          ),
        ),
        if (selectedCount > 0) ...[
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFF00A1DF).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: const Color(0xFF00A1DF),
                width: 1,
              ),
            ),
            child: Text(
              '$selectedCount skill${selectedCount == 1 ? '' : 's'} selected',
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF00A1DF),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
        const SizedBox(height: 16),
      ],
    );
  }
}