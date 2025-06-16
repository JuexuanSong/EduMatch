// lib/models/user_match.dart
class UserMatch {
  final String name;
  final String imageUrl;

  UserMatch({
    required this.name,
    required this.imageUrl,
  });

  // You can add fromJson or toJson methods if serialization/deserialization is needed
  factory UserMatch.fromJson(Map<String, dynamic> json) {
    return UserMatch(
      name: json['name'] as String,
      imageUrl: json['imageUrl'] as String,
    );
  }
}