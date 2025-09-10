import 'user_skill_model.dart';

class UserModel {
  final String userId;
  final String name;
  final String email;
  final String? bio;
  final String? image;
  final String? location;      // Text location (e.g., "New York, NY")
  final double? longitude;     // PostGIS longitude
  final double? latitude;      // PostGIS latitude
  final String? campus;
  final List<String> targetSkills;    // Skills user wants to learn
  final List<String> offerSkills;     // Skills user can teach
  final List<UserSkillModel> userSkills; // Detailed user skills with proficiency
  final DateTime? lastActive;
  final DateTime memberSince;
  final bool isActive;
  final int? matchCount;       // Number of matches user has
  final double? rating;        // User rating (for tutoring)
  
  UserModel({
    required this.userId,
    required this.name,
    required this.email,
    this.bio,
    this.image,
    this.location,
    this.longitude,
    this.latitude,
    this.campus,
    required this.targetSkills,
    required this.offerSkills,
    required this.userSkills,
    this.lastActive,
    required this.memberSince,
    this.isActive = true,
    this.matchCount,
    this.rating,
  });
  
  // Create UserModel from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['user_id'],
      name: json['name'],
      email: json['email'],
      bio: json['bio'],
      image: json['image'],
      location: json['location'],
      longitude: json['longitude']?.toDouble(),
      latitude: json['latitude']?.toDouble(),
      campus: json['campus'],
      targetSkills: List<String>.from(json['target_skills'] ?? []),
      offerSkills: List<String>.from(json['offer_skills'] ?? []),
      userSkills: (json['user_skills'] as List<dynamic>?)
          ?.map((skill) => UserSkillModel.fromJson(skill))
          .toList() ?? [],
      lastActive: json['last_active'] != null 
          ? DateTime.parse(json['last_active']) 
          : null,
      memberSince: DateTime.parse(json['member_since']),
      isActive: json['is_active'] ?? true,
      matchCount: json['match_count'],
      rating: json['rating']?.toDouble(),
    );
  }
  
  // Convert UserModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'name': name,
      'email': email,
      if (bio != null) 'bio': bio,
      if (image != null) 'image': image,
      if (location != null) 'location': location,
      if (longitude != null) 'longitude': longitude,
      if (latitude != null) 'latitude': latitude,
      if (campus != null) 'campus': campus,
      'target_skills': targetSkills,
      'offer_skills': offerSkills,
      'user_skills': userSkills.map((skill) => skill.toJson()).toList(),
      if (lastActive != null) 'last_active': lastActive!.toIso8601String(),
      'member_since': memberSince.toIso8601String(),
      'is_active': isActive,
      if (matchCount != null) 'match_count': matchCount,
      if (rating != null) 'rating': rating,
    };
  }
  
  // Create a copy with some fields changed
  UserModel copyWith({
    String? userId,
    String? name,
    String? email,
    String? bio,
    String? image,
    String? location,
    double? longitude,
    double? latitude,
    String? campus,
    List<String>? targetSkills,
    List<String>? offerSkills,
    List<UserSkillModel>? userSkills,
    DateTime? lastActive,
    DateTime? memberSince,
    bool? isActive,
    int? matchCount,
    double? rating,
  }) {
    return UserModel(
      userId: userId ?? this.userId,
      name: name ?? this.name,
      email: email ?? this.email,
      bio: bio ?? this.bio,
      image: image ?? this.image,
      location: location ?? this.location,
      longitude: longitude ?? this.longitude,
      latitude: latitude ?? this.latitude,
      campus: campus ?? this.campus,
      targetSkills: targetSkills ?? this.targetSkills,
      offerSkills: offerSkills ?? this.offerSkills,
      userSkills: userSkills ?? this.userSkills,
      lastActive: lastActive ?? this.lastActive,
      memberSince: memberSince ?? this.memberSince,
      isActive: isActive ?? this.isActive,
      matchCount: matchCount ?? this.matchCount,
      rating: rating ?? this.rating,
    );
  }
  
  // Get user's skills for a specific role
  List<UserSkillModel> getSkillsByRole(String role) {
    return userSkills.where((skill) => skill.role == role).toList();
  }
  
  // Get user's teaching skills
  List<UserSkillModel> get teachingSkills {
    return getSkillsByRole('TEACH');
  }
  
  // Get user's learning skills
  List<UserSkillModel> get learningSkills {
    return getSkillsByRole('LEARN');
  }
  
  // Check if user has a specific skill
  bool hasSkill(String skillName) {
    return targetSkills.contains(skillName) || offerSkills.contains(skillName);
  }
  
  // Check if user can teach a specific skill
  bool canTeach(String skillName) {
    return offerSkills.contains(skillName);
  }
  
  // Check if user wants to learn a specific skill
  bool wantsToLearn(String skillName) {
    return targetSkills.contains(skillName);
  }
  
  // Get user's full location string
  String get fullLocation {
    if (location != null && campus != null) {
      return '$location ($campus Campus)';
    } else if (location != null) {
      return location!;
    } else if (campus != null) {
      return '$campus Campus';
    } else {
      return 'Location not set';
    }
  }
  
  // Check if user has location coordinates
  bool get hasCoordinates {
    return longitude != null && latitude != null;
  }
  
  // Get user's initials for avatar
  String get initials {
    final names = name.split(' ');
    if (names.length >= 2) {
      return '${names[0][0]}${names[1][0]}'.toUpperCase();
    } else if (names.isNotEmpty) {
      return names[0][0].toUpperCase();
    } else {
      return '?';
    }
  }
  
  // Get user's status (active/inactive)
  String get status {
    if (lastActive == null) return 'Never active';
    
    final difference = DateTime.now().difference(lastActive!);
    if (difference.inMinutes < 5) {
      return 'Online';
    } else if (difference.inHours < 1) {
      return 'Active ${difference.inMinutes} minutes ago';
    } else if (difference.inDays < 1) {
      return 'Active ${difference.inHours} hours ago';
    } else {
      return 'Active ${difference.inDays} days ago';
    }
  }
  
  // Get user's experience level
  String get experienceLevel {
    final totalSkills = offerSkills.length;
    if (totalSkills >= 10) {
      return 'Expert';
    } else if (totalSkills >= 5) {
      return 'Intermediate';
    } else if (totalSkills >= 1) {
      return 'Beginner';
    } else {
      return 'New';
    }
  }
  
  @override
  String toString() {
    return 'UserModel(userId: $userId, name: $name, email: $email)';
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is UserModel &&
        other.userId == userId &&
        other.email == email;
  }
  
  @override
  int get hashCode => userId.hashCode ^ email.hashCode;
}