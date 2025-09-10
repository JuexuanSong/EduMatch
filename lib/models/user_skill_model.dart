class UserSkillModel {
  final int userSkillId;
  final String userId;
  final int skillId;
  final String skillName;
  final String role;           // 'TEACH' or 'LEARN'
  final String? proficiency;   // 'BEGINNER', 'INTERMEDIATE', 'ADVANCED'
  final DateTime createdAt;
  
  UserSkillModel({
    required this.userSkillId,
    required this.userId,
    required this.skillId,
    required this.skillName,
    required this.role,
    this.proficiency,
    required this.createdAt,
  });
  
  factory UserSkillModel.fromJson(Map<String, dynamic> json) {
    return UserSkillModel(
      userSkillId: json['user_skill_id'] ?? 0,
      userId: json['user_id'],
      skillId: json['skill_id'],
      skillName: json['skill_name'],
      role: json['role'],
      proficiency: json['proficiency'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
  
  // Convert UserSkillModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'user_skill_id': userSkillId,
      'user_id': userId,
      'skill_id': skillId,
      'skill_name': skillName,
      'role': role,
      if (proficiency != null) 'proficiency': proficiency,
      'created_at': createdAt.toIso8601String(),
    };
  }

  // Create a copy with some fields changed
  UserSkillModel copyWith({
    int? userSkillId,
    String? userId,
    int? skillId,
    String? skillName,
    String? role,
    String? proficiency,
    DateTime? createdAt,
  }) {
    return UserSkillModel(
      userSkillId: userSkillId ?? this.userSkillId,
      userId: userId ?? this.userId,
      skillId: skillId ?? this.skillId,
      skillName: skillName ?? this.skillName,
      role: role ?? this.role,
      proficiency: proficiency ?? this.proficiency,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}