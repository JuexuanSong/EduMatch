import 'package:flutter/material.dart';

class SkillsAutocomplete extends StatelessWidget {
  final String title;
  final List<String> skills;
  final List<String> availableSkills;
  final Function(String) onSkillAdded;
  final Function(String) onSkillRemoved;

  const SkillsAutocomplete({
    super.key,
    required this.title,
    required this.skills,
    required this.availableSkills,
    required this.onSkillAdded,
    required this.onSkillRemoved,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF00487B), // Dark Navy
          ),
        ),
        const SizedBox(height: 8),
        Autocomplete<String>(
          optionsBuilder: (TextEditingValue textEditingValue) {
            if (textEditingValue.text.isEmpty) {
              return const Iterable<String>.empty();
            }
            return availableSkills.where((String option) {
              return option
                  .toLowerCase()
                  .contains(textEditingValue.text.toLowerCase());
            });
          },
          onSelected: onSkillAdded,
          fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
            return TextField(
              controller: controller,
              focusNode: focusNode,
              decoration: InputDecoration(
                labelText: 'Add a skill',
                labelStyle: const TextStyle(color: Color(0xFF00487B)), // Dark Navy
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.black, width: 1),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.black, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.black, width: 1.5),
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: skills.isEmpty && title == 'Skills I Can Offer'
              ? [
                  const Chip(
                    label: Text('None yet / I’m still learning'),
                    backgroundColor: Colors.grey,
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                ]
              : skills.map((skill) {
                  return Chip(
                    label: Text(skill),
                    backgroundColor:
                        const Color(0xFF00A1DF).withOpacity(0.1), // Light Bright Blue
                    labelStyle:
                        const TextStyle(color: Color(0xFF00A1DF)), // Bright Blue text
                    onDeleted: () => onSkillRemoved(skill),
                    deleteIconColor:
                        const Color(0xFF00A1DF), // Bright Blue delete icon
                  );
                }).toList(),
        ),
      ],
    );
  }
}