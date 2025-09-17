import 'package:flutter/material.dart';
import '../services/skill_service.dart';
import '../widgets/skill/next_button.dart';
import '../widgets/skill/skills_grid.dart';
import '../widgets/skill/skills_header.dart';
import '../widgets/skill/skill_search_bar.dart';
import '../widgets/common/loading_widget.dart';
import 'profile_setup_screen.dart';

class SkillsSelectionScreen extends StatefulWidget {
  const SkillsSelectionScreen({super.key});

  @override
  State<SkillsSelectionScreen> createState() => _SkillsSelectionScreenState();
}

class _SkillsSelectionScreenState extends State<SkillsSelectionScreen> {
  final SkillService _skillService = SkillService();
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> skills = [];
  bool _isLoading = true;
  String? _errorMessage;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _loadSkills();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadSkills() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    // Start with the comprehensive local skill list for better UX
    setState(() {
      skills = getAllSkills();
      _isLoading = false;
    });

    // Optionally try to sync with server in the background
    // This won't show error messages to the user
    try {
      final result = await _skillService.getAllSkills();
      if (mounted && result['success']) {
        final data = result['data'];
        if (data is List && data.isNotEmpty) {
          // Only update if server has more/different skills
          final serverSkills = data.map((skill) => {
            'id': skill['skill_id'],
            'name': skill['name'],
            'icon': _getSkillIcon(skill['name']),
            'selected': false,
          }).toList();
          
          // Preserve user selections when updating from server
          final selectedSkillNames = skills
              .where((skill) => skill['selected'] == true)
              .map((skill) => skill['name'])
              .toSet();
          
          for (var serverSkill in serverSkills) {
            if (selectedSkillNames.contains(serverSkill['name'])) {
              serverSkill['selected'] = true;
            }
          }
          
          setState(() {
            skills = serverSkills;
          });
        }
      }
    } catch (e) {
      // Silently handle server errors - user already has local skills
      // Only log for debugging purposes
      debugPrint('Background skill sync failed: $e');
    }
  }

  List<Map<String, dynamic>> getAllSkills() {
    // Use the same comprehensive skill list as the profile screen
    final List<String> availableSkills = [
      'Python', 'Java', 'C', 'C++', 'C#', 'Ruby on Rails', 'Flutter', 'Dart',
      'JavaScript', 'HTML', 'CSS', 'Kotlin', 'Swift', 'Go', 'PHP', 'SQL',
      'MySQL', 'PostgreSQL', 'MongoDB', 'Django', 'Flask', 'FastAPI',
      'Spring Boot', 'ASP.NET', 'Vue.js', 'Angular', 'TypeScript', 'Rust',
      'Node.js', 'AWS', 'Firebase', 'Azure', 'GCP', 'DevOps', 'UI/UX Design',
      'Figma', 'Deep Learning', 'PyTorch', 'TensorFlow', 'Computer Vision',
      'Machine Learning', 'Cybersecurity', 'AR/VR', 'Game Development',
    ];
    
    return availableSkills.map((skill) => {
      'name': skill,
      'icon': _getSkillIcon(skill),
      'selected': false,
    }).toList();
  }

  IconData _getSkillIcon(String skillName) {
    switch (skillName.toLowerCase()) {
      case 'python':
        return Icons.code;
      case 'java':
        return Icons.coffee;
      case 'c':
      case 'c++':
      case 'c#':
        return Icons.code;
      case 'ruby on rails':
        return Icons.web;
      case 'flutter':
        return Icons.flutter_dash;
      case 'dart':
        return Icons.flutter_dash;
      case 'javascript':
        return Icons.javascript;
      case 'html':
      case 'css':
        return Icons.web;
      case 'kotlin':
      case 'swift':
        return Icons.phone_android;
      case 'go':
      case 'php':
      case 'rust':
        return Icons.code;
      case 'sql':
      case 'mysql':
      case 'postgresql':
      case 'mongodb':
        return Icons.storage;
      case 'django':
      case 'flask':
      case 'fastapi':
      case 'spring boot':
      case 'asp.net':
        return Icons.web;
      case 'vue.js':
      case 'angular':
      case 'react':
        return Icons.web;
      case 'typescript':
        return Icons.javascript;
      case 'node.js':
        return Icons.developer_board;
      case 'aws':
      case 'firebase':
      case 'azure':
      case 'gcp':
        return Icons.cloud;
      case 'devops':
        return Icons.build;
      case 'ui/ux design':
        return Icons.design_services;
      case 'figma':
        return Icons.design_services;
      case 'deep learning':
      case 'pytorch':
      case 'tensorflow':
      case 'computer vision':
      case 'machine learning':
        return Icons.psychology;
      case 'cybersecurity':
        return Icons.security;
      case 'ar/vr':
        return Icons.view_in_ar;
      case 'game development':
        return Icons.gamepad;
      default:
        return Icons.lightbulb;
    }
  }

  void _handleSkillTap(int index) {
    setState(() {
      skills[index]['selected'] = !skills[index]['selected'];
    });
  }

  void _handleNext(List<String> selectedSkills) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProfileSetupScreen(
          selectedSkills: selectedSkills,
        ),
      ),
    );
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
        backgroundColor: const Color(0xFF5A8298),
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFF6E9D7),
              Color(0xFFE9D9F5),
            ],
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header with selection count
                    SkillsHeader(
                      selectedCount: skills.where((s) => s['selected']).length,
                      totalCount: skills.length,
                    ),
                    
                    // Search bar
                    SkillSearchBar(
                      controller: _searchController,
                      onChanged: (query) {
                        setState(() {
                          _searchQuery = query;
                        });
                      },
                    ),
                    
                    // Warning message
                    if (_errorMessage != null)
                      Container(
                        padding: const EdgeInsets.all(12),
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: Colors.orange.shade100,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.orange.shade300),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.warning_amber, color: Colors.orange.shade700),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                _errorMessage!,
                                style: TextStyle(
                                  color: Colors.orange.shade700,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    
                    // Skills Grid or Loading
                    if (_isLoading)
                      const Expanded(
                        child: LoadingWidget(message: 'Loading skills...'),
                      )
                    else
                      SkillsGrid(
                        skills: skills,
                        onSkillTap: _handleSkillTap,
                        searchQuery: _searchQuery,
                      ),
                  ],
                ),
              ),
            ),
            
            // Next Button
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 8,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: NextButton(
                skills: skills,
                onPressed: _handleNext,
                isLoading: false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
