// lib/services/chat_service.dart
import '../models/user_match.dart';
import '../models/chat_message.dart';

// Abstract interface: defines the functions a chat service should provide
abstract class ChatService {
  Future<List<UserMatch>> fetchNewMatches();
  Future<List<ChatMessage>> fetchMessages();
}

// Mock implementation: used for development and testing
class MockChatService implements ChatService {
  @override
  Future<List<UserMatch>> fetchNewMatches() async {
    // Simulate network delay to show loading indicator
    await Future.delayed(const Duration(seconds: 1));

    return [
      UserMatch(name: 'Anita', imageUrl: 'https://randomuser.me/api/portraits/women/1.jpg'),
      UserMatch(name: 'Reshma', imageUrl: 'https://randomuser.me/api/portraits/women/2.jpg'),
      UserMatch(name: 'Roma', imageUrl: 'https://randomuser.me/api/portraits/women/3.jpg'),
      UserMatch(name: 'Yami', imageUrl: 'https://randomuser.me/api/portraits/women/4.jpg'),
      UserMatch(name: 'Priti', imageUrl: 'https://randomuser.me/api/portraits/women/5.jpg'),
    ];
  }

  @override
  Future<List<ChatMessage>> fetchMessages() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    return [
      ChatMessage(senderName: 'Anika', messageContent: 'Oh I don\'t like fish 🐠', unreadCount: 2, senderImageUrl: 'https://randomuser.me/api/portraits/women/6.jpg'),
      ChatMessage(senderName: 'Shreya', messageContent: 'Can we go somewhere?', unreadCount: 1, senderImageUrl: 'https://randomuser.me/api/portraits/women/7.jpg'),
      ChatMessage(senderName: 'Lilly', messageContent: 'You: If I were a stop light, I\'d turn', unreadCount: 0, senderImageUrl: 'https://randomuser.me/api/portraits/women/8.jpg'),
      ChatMessage(senderName: 'Mona', messageContent: 'See you soon 😉', unreadCount: 0, senderImageUrl: 'https://randomuser.me/api/portraits/women/9.jpg'),
      ChatMessage(senderName: 'Sonia', messageContent: 'Are you serious?!', unreadCount: 1, senderImageUrl: 'https://randomuser.me/api/portraits/women/10.jpg'),
      ChatMessage(senderName: 'Monika', messageContent: 'You: How about a movie and', unreadCount: 0, senderImageUrl: 'https://randomuser.me/api/portraits/women/11.jpg'),
      ChatMessage(senderName: 'Katrina', messageContent: 'OK', unreadCount: 0, senderImageUrl: 'https://randomuser.me/api/portraits/women/12.jpg'),
      ChatMessage(senderName: 'Kiran', messageContent: 'You: How are you?', unreadCount: 0, senderImageUrl: 'https://randomuser.me/api/portraits/women/13.jpg'),
    ];
  }
}

// Real API implementation: replace MockChatService with this in production
// class ApiChatService implements ChatService {
//   @override
//   Future<List<UserMatch>> fetchNewMatches() async {
//     // Write real API call here, e.g., using the http package
//     // final response = await http.get(Uri.parse('https://your.api.com/new-matches'));
//     // if (response.statusCode == 200) {
//     //   final List<dynamic> jsonList = json.decode(response.body);
//     //   return jsonList.map((e) => UserMatch.fromJson(e)).toList();
//     // } else {
//     //   throw Exception('Failed to load new matches from API');
//     // }
//     return []; // Temporarily return an empty list
//   }
//
//   @override
//   Future<List<ChatMessage>> fetchMessages() async {
//     // Write real API call here
//     return []; // Temporarily return an empty list
//   }
// }
