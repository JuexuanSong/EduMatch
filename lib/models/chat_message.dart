// lib/models/chat_message.dart
class ChatMessage {
  final String senderName;
  final String messageContent;
  final int unreadCount;
  final String senderImageUrl;

  ChatMessage({
    required this.senderName,
    required this.messageContent,
    required this.unreadCount,
    required this.senderImageUrl,
  });

  // You can add fromJson or toJson methods if serialization/deserialization is needed
  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      senderName: json['senderName'] as String,
      messageContent: json['messageContent'] as String,
      unreadCount: json['unreadCount'] as int,
      senderImageUrl: json['senderImageUrl'] as String,
    );
  }
}
