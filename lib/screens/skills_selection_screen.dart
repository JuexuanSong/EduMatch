import 'package:flutter/material.dart';
import '../widgets/skill/next_button.dart';

class SkillsSelectionScreen extends StatefulWidget {
  const SkillsSelectionScreen({super.key});

  @override
  State<SkillsSelectionScreen> createState() => _SkillsSelectionScreenState();
}

class _SkillsSelectionScreenState extends State<SkillsSelectionScreen> {
  // 
  final List<Map<String, dynamic>> skills = [
    {'name': 'React', 'icon': Icons.web, 'selected': false},
    {'name': 'Python', 'icon': Icons.code, 'selected': false},
    {'name': 'Flutter', 'icon': Icons.phone_android, 'selected': false},
    {'name': 'Java', 'icon': Icons.coffee, 'selected': false},
    {'name': 'SQL', 'icon': Icons.storage, 'selected': false},
    {'name': 'HTML', 'icon': Icons.html, 'selected': false},
    {'name': 'CSS', 'icon': Icons.css, 'selected': false},
    {'name': 'Node.js', 'icon': Icons.developer_board, 'selected': false},
    {'name': 'Dart', 'icon': Icons.flutter_dash, 'selected': false},
    {'name': 'AWS', 'icon': Icons.cloud, 'selected': false},
    {'name': 'Firebase', 'icon': Icons.local_fire_department, 'selected': false},
    {'name': 'C', 'icon': Icons.code, 'selected': false},
    {'name': 'C++', 'icon': Icons.code, 'selected': false},
    {'name': 'AI', 'icon': Icons.psychology, 'selected': false},
    {'name': 'ML', 'icon': Icons.memory, 'selected': false},
    {'name': 'LLM', 'icon': Icons.language, 'selected': false},
    {'name': 'CNN', 'icon': Icons.image, 'selected': false},
    {'name': 'PyTorch', 'icon': Icons.lightbulb, 'selected': false},
    {'name': 'Git', 'icon': Icons.account_tree, 'selected': false},
    {'name': 'Docker', 'icon': Icons.cloud_download, 'selected': false},
    {'name': 'GraphQL', 'icon': Icons.api, 'selected': false},
    {'name': 'Ruby', 'icon': Icons.diamond, 'selected': false},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EduMatch'),
        titleTextStyle: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF5A8298), // Dark Grey Blue
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFF6E9D7), // Light Cream
              Color(0xFFE9D9F5), // Light Purple
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SkillsHeader(),
              SkillsGrid(
                skills: skills,
                onSkillTap: (index) {
                  setState(() {
                    skills[index]['selected'] = !skills[index]['selected'];
                  });
                },
              ),
              NextButton(
                skills: skills,
                onPressed: (selectedSkills) {
                  Navigator.pushNamed(
                    context,
                    '/profile_setup',
                    arguments: selectedSkills,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// SkillsHeader widget
class SkillsHeader extends StatelessWidget {
  const SkillsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'What do you wanna learn about?',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Select at least one subject you’re interested in learning.',
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFF00487B), // Dark Navy
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

// skills grid
class SkillsGrid extends StatelessWidget {
  final List<Map<String, dynamic>> skills;
  final Function(int) onSkillTap;

  const SkillsGrid({
    super.key,
    required this.skills,
    required this.onSkillTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Wrap(
          spacing: 16,
          runSpacing: 16,
          children: skills.asMap().entries.map((entry) {
            final index = entry.key;
            final skill = entry.value;
            return SkillCard(
              name: skill['name'],
              icon: skill['icon'],
              isSelected: skill['selected'],
              onTap: () => onSkillTap(index),
            );
          }).toList(),
        ),
      ),
    );
  }
}

// SkillCard widget
class SkillCard extends StatelessWidget {
  final String name;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const SkillCard({
    super.key,
    required this.name,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: (MediaQuery.of(context).size.width - 48) / 2, // 2 cards per row
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF00A1DF).withOpacity(0.1)
              : Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Color(0xFF5A8298), // Dark Grey Blue
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
          border: isSelected
              ? Border.all(color: const Color(0xFF00A1DF), width: 2)
              : Border.all(color: Colors.transparent),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 36,
              color: isSelected
                  ? const Color(0xFF00A1DF)
                  : const Color(0xFF045A94),
            ),
            const SizedBox(width: 12),
            Text(
              name,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: isSelected
                    ? const Color(0xFF00A1DF)
                    : const Color(0xFF045A94),
              ),
            ),
            if (isSelected)
              const Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Icon(
                  Icons.check_circle,
                  color: Color(0xFF6BAB16), // Bright Green
                  size: 20,
                ),
              ),
          ],
        ),
      ),
    );
  }
}