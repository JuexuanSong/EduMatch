import 'package:flutter/material.dart';
import '../widgets/home/home_tab.dart';
import '../widgets/common/bottom_navigation_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomeTab(),
    const Center(child: Text('People Page (coming soon)')),
    const Center(child: Text('Chat Page (coming soon)')), // placeholder to keep _pages length consistent
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          if (index == 2) {
            Navigator.pushNamed(context, '/chat'); // route to chat screen
            return; // prevent changing index
          }
          setState(() => _selectedIndex = index);
        },
      ),
    );
  }
}
