class UserProfile {
  final int id;
  final String name;
  final String bio;
  final String imageUrl;
  final List<String> canTeach;
  final List<String> wannaLearn;

  UserProfile({
    required this.id,
    required this.name,
    required this.bio,
    required this.imageUrl,
    required this.canTeach,
    required this.wannaLearn,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'] != null ? json['id'] as int : 0,
          name: json['name'] ?? '',
          bio: json['bio'] ?? '',
          imageUrl: json['imageUrl'] ?? '',
          canTeach: List<String>.from(json['canTeach'] ?? []),
          wannaLearn: List<String>.from(json['wannaLearn'] ?? []),
    );
  }
}

class Match {
  final int id;
  final int user1Id;
  final int user2Id;
  final UserProfile user1;
  final UserProfile user2;

  Match({
    required this.id,
    required this.user1Id,
    required this.user2Id,
    required this.user1,
    required this.user2,
  });

  factory Match.fromJson(Map<String, dynamic> json) {
    return Match(
      id: json['id'] != null ? json['id'] as int : 0, // fallback 0
          user1Id: json['user1_id'] != null ? json['user1_id'] as int : 0,
          user2Id: json['user2_id'] != null ? json['user2_id'] as int : 0,
          user1: UserProfile.fromJson(json['user1'] ?? {}),
          user2: UserProfile.fromJson(json['user2'] ?? {}),
    );
  }
}
