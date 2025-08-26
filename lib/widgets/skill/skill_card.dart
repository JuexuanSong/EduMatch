import 'package:flutter/material.dart';

class SkillCard extends StatelessWidget {
  final String name;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;
  final double? width;
  final bool showCheckmark;

  const SkillCard({
    super.key,
    required this.name,
    required this.icon,
    required this.isSelected,
    required this.onTap,
    this.width,
    this.showCheckmark = true,
  });

  @override
  Widget build(BuildContext context) {
    final cardWidth = width ?? (MediaQuery.of(context).size.width - 48) / 2;
    
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: cardWidth,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF00A1DF).withValues(alpha: 0.1)
              : Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: isSelected 
                  ? const Color(0xFF00A1DF).withValues(alpha: 0.3)
                  : const Color(0xFF5A8298).withValues(alpha: 0.2),
              blurRadius: isSelected ? 8 : 4,
              offset: const Offset(0, 2),
            ),
          ],
          border: isSelected
              ? Border.all(color: const Color(0xFF00A1DF), width: 2)
              : Border.all(color: Colors.grey.shade200),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon
            AnimatedScale(
              scale: isSelected ? 1.1 : 1.0,
              duration: const Duration(milliseconds: 200),
              child: Icon(
                icon,
                size: 36,
                color: isSelected
                    ? const Color(0xFF00A1DF)
                    : const Color(0xFF045A94),
              ),
            ),
            const SizedBox(height: 12),
            
            // Skill Name
            Text(
              name,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isSelected
                    ? const Color(0xFF00A1DF)
                    : const Color(0xFF045A94),
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            
            // Checkmark
            if (isSelected && showCheckmark) ...[
              const SizedBox(height: 8),
              const Icon(
                Icons.check_circle,
                color: Color(0xFF6BAB16),
                size: 20,
              ),
            ],
          ],
        ),
      ),
    );
  }
}