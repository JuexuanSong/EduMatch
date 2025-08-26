import 'package:flutter/material.dart';
import 'skill_card.dart';

class SkillsGrid extends StatelessWidget {
  final List<Map<String, dynamic>> skills;
  final Function(int) onSkillTap;
  final bool isLoading;
  final String? searchQuery;

  const SkillsGrid({
    super.key,
    required this.skills,
    required this.onSkillTap,
    this.isLoading = false,
    this.searchQuery,
  });

  List<Map<String, dynamic>> get filteredSkills {
    if (searchQuery == null || searchQuery!.isEmpty) {
      return skills;
    }
    return skills.where((skill) {
      return skill['name']
          .toString()
          .toLowerCase()
          .contains(searchQuery!.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Expanded(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF00A1DF)),
              ),
              SizedBox(height: 16),
              Text(
                'Loading skills...',
                style: TextStyle(
                  color: Color(0xFF00487B),
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      );
    }

    final filtered = filteredSkills;
    
    if (filtered.isEmpty) {
      return Expanded(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.search_off,
                size: 64,
                color: Colors.grey.shade400,
              ),
              const SizedBox(height: 16),
              Text(
                searchQuery != null && searchQuery!.isNotEmpty
                    ? 'No skills found for "$searchQuery"'
                    : 'No skills available',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Expanded(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: LayoutBuilder(
          builder: (context, constraints) {
            // Calculate number of columns based on screen width
            final screenWidth = constraints.maxWidth;
            final cardWidth = 160.0; // Minimum card width
            final spacing = 16.0;
            final columns = ((screenWidth + spacing) / (cardWidth + spacing)).floor();
            final actualColumns = columns > 0 ? columns : 1;
            
            return Wrap(
              spacing: spacing,
              runSpacing: spacing,
              children: filtered.asMap().entries.map((entry) {
                final originalIndex = skills.indexOf(entry.value);
                final skill = entry.value;
                
                return SizedBox(
                  width: (screenWidth - (spacing * (actualColumns - 1))) / actualColumns,
                  child: SkillCard(
                    name: skill['name'],
                    icon: skill['icon'],
                    isSelected: skill['selected'],
                    onTap: () => onSkillTap(originalIndex),
                  ),
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}