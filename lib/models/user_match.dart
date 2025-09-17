class UserProfile {
  final int id;
  final String username; // backend "username"
  final String bio;
  final String imageUrl;
  final List<String> canTeach;
  final List<String> wannaLearn;

  UserProfile({
    required this.id,
    required this.username,
    required this.bio,
    required this.imageUrl,
    required this.canTeach,
    required this.wannaLearn,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'] ?? 0,
      username: json['username'] ?? '',
      bio: json['bio'] ?? '',
      imageUrl: json['image_url'] ?? '',
      canTeach: List<String>.from(json['can_teach'] ?? []),
      wannaLearn: List<String>.from(json['wanna_learn'] ?? []),
    );
  }
}

class Match {
  final int id;
  final UserProfile user1;
  final UserProfile user2;

  Match({
    required this.id,
    required this.user1,
    required this.user2,
  });

  factory Match.fromJson(Map<String, dynamic> json) {
    return Match(
      id: json['id'] ?? 0,
      user1: UserProfile.fromJson(json['user1'] ?? {}),
      user2: UserProfile.fromJson(json['user2'] ?? {}),
    );
  }
}
