import 'package:flutter/material.dart';
import 'screens/login_screen.dart'; // Import the LoginPage

void main() {
  runApp(const MyApp()); // use const here
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EduMatch',
      theme: ThemeData(fontFamily: 'Arial'),
      home: const LoginScreen(), // Use the LoginPage widget here
    );
  }
}

