import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_match.dart';

class MatchesService {
  Future<List<Match>> fetchMatches(int userId) async {
    final url = Uri.parse('http://10.0.0.237:8000/api/matches/?user_id=$userId'); //change this url according to run on your device
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => Match.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load matches');
    }
  }
}
