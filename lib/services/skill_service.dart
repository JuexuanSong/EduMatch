// lib/services/skill_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SkillService {
  static const String baseUrl = 'http://10.0.2.2:8000/api';
  
  // Get stored token
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }
  
  // Get headers with token
  Future<Map<String, String>> getHeaders() async {
    final token = await getToken();
    return {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Token $token',
    };
  }
  
  // Get All Skills
  Future<Map<String, dynamic>> getAllSkills() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/skills/'),
        headers: await getHeaders(),
      );
      
      final data = json.decode(response.body);
      
      if (response.statusCode == 200) {
        return {'success': true, 'data': data};
      } else {
        return {'success': false, 'error': data};
      }
    } catch (e) {
      return {'success': false, 'error': 'Network error: $e'};
    }
  }
  
  // Create New Skill
  Future<Map<String, dynamic>> createSkill({
    required String name,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/skills/create/'),
        headers: await getHeaders(),
        body: json.encode({'name': name}),
      );
      
      final data = json.decode(response.body);
      
      if (response.statusCode == 201) {
        return {'success': true, 'data': data};
      } else {
        return {'success': false, 'error': data};
      }
    } catch (e) {
      return {'success': false, 'error': 'Network error: $e'};
    }
  }
  
  // Search Skills
  Future<Map<String, dynamic>> searchSkills({
    required String query,
  }) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/skills/?search=${Uri.encodeComponent(query)}'),
        headers: await getHeaders(),
      );
      
      final data = json.decode(response.body);
      
      if (response.statusCode == 200) {
        return {'success': true, 'data': data};
      } else {
        return {'success': false, 'error': data};
      }
    } catch (e) {
      return {'success': false, 'error': 'Network error: $e'};
    }
  }
  
  // Get Skills by Category (if you add this feature later)
  Future<Map<String, dynamic>> getSkillsByCategory({
    required String category,
  }) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/skills/?category=${Uri.encodeComponent(category)}'),
        headers: await getHeaders(),
      );
      
      final data = json.decode(response.body);
      
      if (response.statusCode == 200) {
        return {'success': true, 'data': data};
      } else {
        return {'success': false, 'error': data};
      }
    } catch (e) {
      return {'success': false, 'error': 'Network error: $e'};
    }
  }
  
  // Get Popular Skills (most used skills)
  Future<Map<String, dynamic>> getPopularSkills({
    int limit = 20,
  }) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/skills/popular/?limit=$limit'),
        headers: await getHeaders(),
      );
      
      final data = json.decode(response.body);
      
      if (response.statusCode == 200) {
        return {'success': true, 'data': data};
      } else {
        return {'success': false, 'error': data};
      }
    } catch (e) {
      return {'success': false, 'error': 'Network error: $e'};
    }
  }
  
  // Get skills with user count (how many users have each skill)
  Future<Map<String, dynamic>> getSkillsWithUserCount() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/skills/stats/'),
        headers: await getHeaders(),
      );
      
      final data = json.decode(response.body);
      
      if (response.statusCode == 200) {
        return {'success': true, 'data': data};
      } else {
        return {'success': false, 'error': data};
      }
    } catch (e) {
      return {'success': false, 'error': 'Network error: $e'};
    }
  }
  
  // Get User's Skills (target and offer skills) by user ID
  Future<Map<String, dynamic>> getUserSkills({
    required String userId,
  }) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/skills/user/$userId/'),
        headers: await getHeaders(),
      );
      
      final data = json.decode(response.body);
      
      if (response.statusCode == 200) {
        return {'success': true, 'data': data};
      } else {
        return {'success': false, 'error': data};
      }
    } catch (e) {
      return {'success': false, 'error': 'Network error: $e'};
    }
  }
  
  // Get skills that are most wanted to learn
  Future<Map<String, dynamic>> getMostWantedSkills({
    int limit = 10,
  }) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/skills/most-wanted/?limit=$limit'),
        headers: await getHeaders(),
      );
      
      final data = json.decode(response.body);
      
      if (response.statusCode == 200) {
        return {'success': true, 'data': data};
      } else {
        return {'success': false, 'error': data};
      }
    } catch (e) {
      return {'success': false, 'error': 'Network error: $e'};
    }
  }
  
  // Get skills that are most offered to teach
  Future<Map<String, dynamic>> getMostOfferedSkills({
    int limit = 10,
  }) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/skills/most-offered/?limit=$limit'),
        headers: await getHeaders(),
      );
      
      final data = json.decode(response.body);
      
      if (response.statusCode == 200) {
        return {'success': true, 'data': data};
      } else {
        return {'success': false, 'error': data};
      }
    } catch (e) {
      return {'success': false, 'error': 'Network error: $e'};
    }
  }
  
  // Get skill details by ID
  Future<Map<String, dynamic>> getSkillById({
    required int skillId,
  }) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/skills/$skillId/'),
        headers: await getHeaders(),
      );
      
      final data = json.decode(response.body);
      
      if (response.statusCode == 200) {
        return {'success': true, 'data': data};
      } else {
        return {'success': false, 'error': data};
      }
    } catch (e) {
      return {'success': false, 'error': 'Network error: $e'};
    }
  }
  
  // Get similar skills (if you implement skill similarity later)
  Future<Map<String, dynamic>> getSimilarSkills({
    required String skillName,
    int limit = 5,
  }) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/skills/similar/?skill=${Uri.encodeComponent(skillName)}&limit=$limit'),
        headers: await getHeaders(),
      );
      
      final data = json.decode(response.body);
      
      if (response.statusCode == 200) {
        return {'success': true, 'data': data};
      } else {
        return {'success': false, 'error': data};
      }
    } catch (e) {
      return {'success': false, 'error': 'Network error: $e'};
    }
  }
  
  // Get trending skills (skills that are gaining popularity)
  Future<Map<String, dynamic>> getTrendingSkills({
    int limit = 10,
  }) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/skills/trending/?limit=$limit'),
        headers: await getHeaders(),
      );
      
      final data = json.decode(response.body);
      
      if (response.statusCode == 200) {
        return {'success': true, 'data': data};
      } else {
        return {'success': false, 'error': data};
      }
    } catch (e) {
      return {'success': false, 'error': 'Network error: $e'};
    }
  }
  
  // Validate skill name before creating
  Future<Map<String, dynamic>> validateSkillName({
    required String name,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/skills/validate/'),
        headers: await getHeaders(),
        body: json.encode({'name': name}),
      );
      
      final data = json.decode(response.body);
      
      if (response.statusCode == 200) {
        return {'success': true, 'data': data};
      } else {
        return {'success': false, 'error': data};
      }
    } catch (e) {
      return {'success': false, 'error': 'Network error: $e'};
    }
  }
  
  // Get skill suggestions based on user's current skills
  Future<Map<String, dynamic>> getSkillSuggestions({
    List<String>? currentSkills,
    int limit = 10,
  }) async {
    try {
      final Map<String, dynamic> body = {};
      if (currentSkills != null) {
        body['current_skills'] = currentSkills;
      }
      body['limit'] = limit;
      
      final response = await http.post(
        Uri.parse('$baseUrl/skills/suggestions/'),
        headers: await getHeaders(),
        body: json.encode(body),
      );
      
      final data = json.decode(response.body);
      
      if (response.statusCode == 200) {
        return {'success': true, 'data': data};
      } else {
        return {'success': false, 'error': data};
      }
    } catch (e) {
      return {'success': false, 'error': 'Network error: $e'};
    }
  }
  
  // Get skills by programming language category
  Future<Map<String, dynamic>> getSkillsByProgrammingLanguage() async {
    return await getSkillsByCategory(category: 'programming');
  }
  
  // Get skills by framework category
  Future<Map<String, dynamic>> getSkillsByFramework() async {
    return await getSkillsByCategory(category: 'framework');
  }
  
  // Get skills by database category
  Future<Map<String, dynamic>> getSkillsByDatabase() async {
    return await getSkillsByCategory(category: 'database');
  }
  
  // Get skills by cloud platform category
  Future<Map<String, dynamic>> getSkillsByCloudPlatform() async {
    return await getSkillsByCategory(category: 'cloud');
  }
  
  // Get skills by design category
  Future<Map<String, dynamic>> getSkillsByDesign() async {
    return await getSkillsByCategory(category: 'design');
  }
}
