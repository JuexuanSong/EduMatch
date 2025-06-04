import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/skills_selection_screen.dart';
import 'screens/profile_setup_screen.dart';

void main() {
  runApp(const MyApp());
}

/// MyApp is the root widget of the application.
/// It sets up the MaterialApp and defines the home screen.
/// StatelessWidget is used because MyApp does not maintain any state.
/// super.key is used to pass the key to the parent widget.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EduMatch',
      theme: ThemeData(
        fontFamily: 'Arial',
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.blue, // base color
          accentColor: const Color(0xFF6BAB16), // Bright Green as secondary color
        ).copyWith(
          primary: const Color(0xFF00A1DF), // set primary color to Bright Blue
          secondary: const Color(0xFF6BAB16), // set secondary color to Bright Green
        ),
      ),
      initialRoute: '/login', // Set the initial route to '/login'
      routes: {
        '/login': (context) => const LoginScreen(),
        '/skills_selection': (context) => const SkillsSelectionScreen(),
        '/profile_setup': (context) => const ProfileSetupScreen(),
      },
    );
  }
}