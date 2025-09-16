import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_match.dart';

class ApiMatchService {
  // Replace with your local or deployed Django endpoint
  static const String baseUrl = 'http://127.0.0.1:8000/api/matches/';

  // Fetch matches from backend
  Future<List<UserMatch>> fetchMatches() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);

        return data.map((jsonItem) => UserMatch.fromJson(jsonItem)).toList();
      } else {
        throw Exception('Failed to fetch matches: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching matches: $e');
      return [];
    }
  }
}
