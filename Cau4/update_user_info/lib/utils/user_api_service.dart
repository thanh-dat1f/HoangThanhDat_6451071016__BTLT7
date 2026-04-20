import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';

class UserApiService {
  static const String _baseUrl = 'https://jsonplaceholder.typicode.com';

  static Future<User> fetchUser(int id) async {
    final response = await http.get(Uri.parse('$_baseUrl/users/$id'));
    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    }
    throw Exception('Không thể tải user');
  }

  static Future<User> updateUser(int id, User user) async {
    final response = await http.put(
      Uri.parse('$_baseUrl/users/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(user.toJson()),
    );
    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    }
    throw Exception('Không thể cập nhật user');
  }
}