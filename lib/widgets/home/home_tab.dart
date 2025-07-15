// This holds profile + suggestions + trending.

import 'package:flutter/material.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    final trendingTags = {
      'Python': 'A versatile programming language used for web, data, and AI.',
      'Cloud Computing': 'Delivery of computing services over the internet.',
      'Visa': 'Document or endorsement for international travel or study.',
      'Language Exchange': 'Mutual language learning between native speakers.',
      'Machine Learning': 'AI technique that learns patterns from data.',
      'Java': 'Popular OOP language for Android, enterprise, and web apps.',
    };

    return Container(
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
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 32), 

              // Profile Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'your name',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF00487B),
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'basic info',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: Colors.grey,
                  ),
                ],
              ),
              const SizedBox(height: 28),

              // People Suggestions
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'People you might be interested in',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF00487B),
                    ),
                  ),
                  Text(
                    'more',
                    style: TextStyle(
                      color: Color(0xFF00A1DF),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 150,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: 3,
                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                  itemBuilder: (context, index) => Container(
                    width: 100,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFF00A1DF), width: 1.5),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Center(
                      child: Text(
                        'User',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF00487B),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Trending Section
              const Text(
                'Trending',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF00487B),
                ),
              ),
              const SizedBox(height: 16),

              // Each tag space
              Column(
                children: trendingTags.entries.map((entry) {
                  final tag = entry.key;
                  final description = entry.value;

                  return GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: Text(tag),
                          content: Text(description),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Close'),
                            ),
                          ],
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.symmetric(
                          vertical: 14, horizontal: 18),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.transparent, // 
                        border: Border.all(color: Color(0xFF00A1DF)),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Text(
                        tag,
                        style: const TextStyle(
                          color: Color(0xFF00487B),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
