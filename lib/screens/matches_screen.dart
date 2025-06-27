import 'package:flutter/material.dart';
import 'package:swipe_cards/draggable_card.dart';
import 'package:swipe_cards/swipe_cards.dart';
import '../widgets/common/bottom_navigation_bar.dart';

class MatchesScreen extends StatefulWidget {
  const MatchesScreen({Key? key}) : super(key: key);

  @override
  State<MatchesScreen> createState() => _MatchesScreenState();
}

class _MatchesScreenState extends State<MatchesScreen> {
  late MatchEngine _matchEngine;
  List<SwipeItem> _swipeItems = [];
  int _currentIndex = 1;

  final Map<String, String> skillDescriptions = {
    'Photoshop': 'Image editing and graphic design tool.',
    'Biology': 'Study of living organisms.',
    'Flutter': 'Framework for building cross-platform apps.',
    'Java': 'Popular programming language for Android and backend.',
    '3D Modeling': 'Creating digital 3D objects.',
    'Math': 'Study of numbers and patterns.',
    'Python': 'Versatile language for web and data science.',
    'Excel': 'Spreadsheet tool for data analysis.',
    'Data Analysis': 'Extracting insights from data.',
    'UI/UX': 'Designing user-friendly interfaces.',
    'React': 'JavaScript library for building UIs.',
    'Speaking': 'Improving verbal communication skills.',
  };

  final List<Map<String, dynamic>> profiles = [
    {
      'name': 'Alice',
      'bio': 'Love biology and design!',
      'image': 'assets/profilePics/profile1.jpg',
      'canTeach': ['Photoshop', 'Biology', 'Flutter'],
      'wannaLearn': ['Java', '3D Modeling', 'Math']
    },
    {
      'name': 'Bob',
      'bio': 'Data nerd, code lover.',
      'image': 'assets/profilePics/profile2.jpg',
      'canTeach': ['Python', 'Excel', 'Data Analysis'],
      'wannaLearn': ['UI/UX', 'React', 'Speaking']
    },
  ];

  @override
  void initState() {
    super.initState();
    for (var profile in profiles) {
      _swipeItems.add(SwipeItem(
        content: profile,
        likeAction: () async => Future.value(),
        nopeAction: () async => Future.value(),
        superlikeAction: () async => Future.value(),
        onSlideUpdate: (SlideRegion? region) async => null,
      ));
    }

    _matchEngine = MatchEngine(swipeItems: _swipeItems);
  }

  void _onTabTapped(int index) {
    if (index == _currentIndex) return;
    setState(() => _currentIndex = index);

    if (index == 0) {
      Navigator.pushReplacementNamed(context, '/home');
    } else if (index == 1) {
      Navigator.pushReplacementNamed(context, '/people');
    } else if (index == 2) {
      Navigator.pushReplacementNamed(context, '/chat');
    }
  }

  Widget _buildSkillChip(String skill, Color bgColor) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(skill),
            content: Text(skillDescriptions[skill] ?? 'No description available.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Close'),
              )
            ],
          ),
        );
      },
      child: Chip(
        label: Text(skill),
        backgroundColor: bgColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF6E9D7), Color(0xFFE9D9F5)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: SwipeCards(
              matchEngine: _matchEngine,
              itemBuilder: (BuildContext context, int index) {
                final profile = _swipeItems[index].content;
                return Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  elevation: 8,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: Image.asset(
                                profile['image'],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            profile['name'],
                            style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Text(profile['bio'], textAlign: TextAlign.center),
                          const SizedBox(height: 16),
                          const Text('I can teach', style: TextStyle(fontWeight: FontWeight.bold)),
                          Wrap(
                            spacing: 6,
                            children: List<Widget>.from(
                              profile['canTeach'].map<Widget>(
                                    (s) => _buildSkillChip(s, Colors.blue.shade100),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text('I want to learn', style: TextStyle(fontWeight: FontWeight.bold)),
                          Wrap(
                            spacing: 6,
                            children: List<Widget>.from(
                              profile['wannaLearn'].map<Widget>(
                                    (s) => _buildSkillChip(s, Colors.green.shade100),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              onStackFinished: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("No more profiles")),
                );
              },
              itemChanged: (SwipeItem item, int index) {},
              upSwipeAllowed: false,
              fillSpace: true,
            ),
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
    );
  }
}
