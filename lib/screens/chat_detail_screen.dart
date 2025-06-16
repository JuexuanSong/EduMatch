// lib/screens/chat_detail_screen.dart
import 'package:flutter/material.dart';
import '../models/user_match.dart'; // Import the complete UserMatch object if needed

class ChatDetailScreen extends StatelessWidget {
  final UserMatch user; // Receives the UserMatch object

  const ChatDetailScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    // You can use Theme.of(context).colorScheme.primary or secondary to get theme colors
    final Color primaryColor = Theme.of(context).colorScheme.primary;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor, // Use theme primary color as AppBar background
        title: Row(
          children: [
            CircleAvatar(
              radius: 18, // Smaller avatar
              backgroundImage: NetworkImage(user.imageUrl),
            ),
            const SizedBox(width: 10),
            Text(
              user.name,
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
          ],
        ),
        iconTheme: const IconThemeData(color: Colors.white), // Set back arrow color
      ),
      body: Column(
        children: [
          // This is the conversation display area. You can use ListView.builder to show messages.
          Expanded(
            child: Center(
              child: Text('Conversation history with ${user.name} will be displayed here.'),
              // In a real app, this would be a ListView.builder displaying actual messages
            ),
          ),
          // This is the message input field
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Enter message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide.none, // Remove border lines
                      ),
                      filled: true,
                      fillColor: Colors.grey[200], // Background fill color
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                FloatingActionButton(
                  onPressed: () {
                    // Logic to send a message
                  },
                  backgroundColor: primaryColor, // Use theme primary color for send button
                  mini: true, // Mini size button
                  child: const Icon(Icons.send, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
