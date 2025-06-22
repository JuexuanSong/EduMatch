// lib/widgets/chat/message_list.dart
import 'package:flutter/material.dart';
import '../../models/chat_message.dart';
import '../../models/user_match.dart';
import '../../screens/chat_detail_screen.dart';

class MessageList extends StatelessWidget {
  final List<ChatMessage> messages;
  final Color secondaryColor;

  const MessageList({
    super.key,
    required this.messages,
    required this.secondaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final message = messages[index];
        // Create a temporary UserMatch object for each message to pass to ChatDetailScreen
        // In a real app, you might want to look up a full UserMatch by sender ID
        final userForChat = UserMatch(
          name: message.senderName,
          imageUrl: message.senderImageUrl,
        );

        return GestureDetector( // Use GestureDetector to make it clickable
          onTap: () {
            // Navigate to ChatDetailScreen on tap
            Navigator.pushNamed(
              context,
              '/chat_detail',
              arguments: userForChat, // Pass the temporary UserMatch object
            );
          },
          child: Padding(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(message.senderImageUrl),
                  backgroundColor: Colors.grey[200],
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        message.senderName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        message.messageContent,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
                if (message.unreadCount > 0)
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: secondaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      message.unreadCount.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
