class SkillModel {
  final int skillId;
  final String name;
  final int? userCount;        // How many users have this skill
  final int? learnCount;       // How many users want to learn this skill
  final int? teachCount;       // How many users can teach this skill
  final String? category;      // Skill category (programming, design, etc.)
  final String? description;   // Skill description
  final bool? isTrending;      // Is this skill trending
  final DateTime? createdAt;   // When skill was created
  
  SkillModel({
    required this.skillId,
    required this.name,
    this.userCount,
    this.learnCount,
    this.teachCount,
    this.category,
    this.description,
    this.isTrending,
    this.createdAt,
  });
  
  // Create SkillModel from JSON
  factory SkillModel.fromJson(Map<String, dynamic> json) {
    return SkillModel(
      skillId: json['skill_id'],
      name: json['name'],
      userCount: json['user_count'],
      learnCount: json['learn_count'],
      teachCount: json['teach_count'],
      category: json['category'],
      description: json['description'],
      isTrending: json['is_trending'],
      createdAt: json['created_at'] != null 
          ? DateTime.parse(json['created_at']) 
          : null,
    );
  }
  
  // Convert SkillModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'skill_id': skillId,
      'name': name,
      if (userCount != null) 'user_count': userCount,
      if (learnCount != null) 'learn_count': learnCount,
      if (teachCount != null) 'teach_count': teachCount,
      if (category != null) 'category': category,
      if (description != null) 'description': description,
      if (isTrending != null) 'is_trending': isTrending,
      if (createdAt != null) 'created_at': createdAt!.toIso8601String(),
    };
  }
  
  // Create a copy with some fields changed
  SkillModel copyWith({
    int? skillId,
    String? name,
    int? userCount,
    int? learnCount,
    int? teachCount,
    String? category,
    String? description,
    bool? isTrending,
    DateTime? createdAt,
  }) {
    return SkillModel(
      skillId: skillId ?? this.skillId,
      name: name ?? this.name,
      userCount: userCount ?? this.userCount,
      learnCount: learnCount ?? this.learnCount,
      teachCount: teachCount ?? this.teachCount,
      category: category ?? this.category,
      description: description ?? this.description,
      isTrending: isTrending ?? this.isTrending,
      createdAt: createdAt ?? this.createdAt,
    );
  }
  
  @override
  String toString() {
    return 'SkillModel(skillId: $skillId, name: $name, userCount: $userCount)';
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SkillModel &&
        other.skillId == skillId &&
        other.name == name;
  }
  
  @override
  int get hashCode => skillId.hashCode ^ name.hashCode;
}