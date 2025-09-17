import 'package:flutter/material.dart';
import 'screens/matches_screen.dart';

void main() {
  runApp(const EduMatchApp());
}

class EduMatchApp extends StatelessWidget {
  const EduMatchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EduMatch',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MatchesScreen(currentUserId: 2), // set test user here
    );
  }
}
