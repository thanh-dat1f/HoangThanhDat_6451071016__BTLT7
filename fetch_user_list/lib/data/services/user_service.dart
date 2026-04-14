import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../utils/api_constants.dart';

class UserService {
  const UserService();

  Future<List<dynamic>> fetchUsersRaw() async {
    final primary = await _getUsers(Uri.parse(ApiConstants.usersEndpoint));
    if (primary != null) return primary;

    final fallback = await _getUsers(
      Uri.parse(ApiConstants.fallbackUsersEndpoint),
    );
    if (fallback != null) return fallback;

    throw Exception('Failed to fetch users from all configured endpoints');
  }

  Future<List<dynamic>?> _getUsers(Uri url) async {
    final response = await http.get(
      url,
      headers: const {
        'Accept': 'application/json',
        'User-Agent': 'fetch_user_list_app',
      },
    );

    if (response.statusCode != 200) return null;

    final data = jsonDecode(response.body);
    if (data is List<dynamic>) return data;
    if (data is Map<String, dynamic> && data['users'] is List<dynamic>) {
      return data['users'] as List<dynamic>;
    }

    return null;
  }
}
