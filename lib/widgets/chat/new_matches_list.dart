// lib/widgets/chat/new_matches_list.dart
import 'package:flutter/material.dart';
import '../../models/user_match.dart';
import '../../screens/chat_detail_screen.dart';

class NewMatchesList extends StatelessWidget {
  final List<UserMatch> matches;

  const NewMatchesList({super.key, required this.matches});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: matches.length,
        itemBuilder: (context, index) {
          final userMatch = matches[index];
          return GestureDetector( // Use GestureDetector to make it clickable
            onTap: () {
              // Navigate to ChatDetailScreen on tap
              Navigator.pushNamed(
                context,
                '/chat_detail', // Use named route
                arguments: userMatch, // Pass the entire UserMatch object as an argument
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(userMatch.imageUrl),
                    backgroundColor: Colors.grey[200],
                  ),
                  const SizedBox(height: 5),
                  Text(
                    userMatch.name,
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
