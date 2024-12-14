import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lab2/models/jokes.dart';

class ApiService {
  final String baseUrl = 'https://official-joke-api.appspot.com';

  Future<List<String>> getJokeTypes() async {
    final response = await http.get(Uri.parse('$baseUrl/types'));

    if (response.statusCode == 200) {
      return List<String>.from(json.decode(response.body));
    } else {
      throw Exception('Failed to load joke types');
    }
  }

  Future<List<JokeModel>> getJokesByType(String type) async {
    final response = await http.get(Uri.parse('$baseUrl/jokes/$type/ten'));

    if (response.statusCode == 200) {
      final List<dynamic> jokeJson = json.decode(response.body);
      return jokeJson.map((joke) => JokeModel.fromJson(joke)).toList();
    } else {
      throw Exception('Failed to load jokes');
    }
  }

  Future<JokeModel> getRandomJoke() async {
    final response = await http.get(Uri.parse('$baseUrl/random_joke'));

    if (response.statusCode == 200) {
      return JokeModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load random joke');
    }
  }
}
