import 'package:flutter/material.dart';
import '../widgets/profile/avatar_section.dart';
import '../widgets/profile/profile_text_fields.dart';
import '../widgets/common/skills_autocomplete.dart';
import '../widgets/profile/save_button.dart';
import '../widgets/common/bottom_navigation_bar.dart';

class ProfileSetupScreen extends StatefulWidget {
  const ProfileSetupScreen({super.key});

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _schoolController = TextEditingController();
  List<String> targetSkills = [];
  List<String> offerSkills = [];
  String? _errorMessage;

  // List of available skills for autocomplete
  final List<String> availableSkills = [
    'Flutter',
    'Dart',
    'Python',
    'Java',
    'UI/UX Design',
    'Data Analysis',
    'React',
    'SQL',
    'HTML',
    'CSS',
    'Node.js',
    'AWS',
    'Firebase',
    'C',
    'C++',
    'AI',
    'ML',
    'LLM',
    'CNN',
    'PyTorch',
    'Git',
    'Docker',
    'GraphQL',
    'Ruby',
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // fetch selected skills from the previous screen
    final List<String>? selectedSkills =
        ModalRoute.of(context)!.settings.arguments as List<String>?;
    if (selectedSkills != null) {
      setState(() {
        targetSkills = selectedSkills;
      });
    }
  }

  void _validateAndSave() {
    if (_nameController.text.isEmpty ||
        _locationController.text.isEmpty ||
        _schoolController.text.isEmpty) {
      setState(() {
        _errorMessage = 'Please fill in all required fields.';
      });
    } else {
      setState(() {
        _errorMessage = null;
      });
      Navigator.pushNamed(context, '/home');
    }
  }

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
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Set up your profile so others can find you!',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF00487B), // Dark Navy
                ),
              ),
              const SizedBox(height: 16),
              const AvatarSection(),
              const SizedBox(height: 16),
              ProfileTextFields(
                nameController: _nameController,
                locationController: _locationController,
                schoolController: _schoolController,
              ),
              const SizedBox(height: 24),
              SkillsAutocomplete(
                title: 'Target Skills',
                skills: targetSkills,
                availableSkills: availableSkills,
                onSkillAdded: (skill) {
                  setState(() {
                    if (!targetSkills.contains(skill)) {
                      targetSkills.add(skill);
                    }
                  });
                },
                onSkillRemoved: (skill) {
                  setState(() {
                    targetSkills.remove(skill);
                  });
                },
              ),
              const SizedBox(height: 24),
              SkillsAutocomplete(
                title: 'Skills I Can Offer',
                skills: offerSkills,
                availableSkills: availableSkills,
                onSkillAdded: (skill) {
                  setState(() {
                    if (!offerSkills.contains(skill)) {
                      offerSkills.add(skill);
                    }
                  });
                },
                onSkillRemoved: (skill) {
                  setState(() {
                    offerSkills.remove(skill);
                  });
                },
              ),
              const SizedBox(height: 16),
              SaveButton(
                errorMessage: _errorMessage,
                onPressed: _validateAndSave,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {
          if (index == 1) {
            Navigator.pushNamed(context, '/people');
          } else if (index == 2) {
            Navigator.pushNamed(context, '/chat');
          }
        },
      ),
    );
  }
}