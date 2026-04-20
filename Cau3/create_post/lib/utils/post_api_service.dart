import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/post_model.dart';

class PostApiService {
  static const String _baseUrl = 'https://jsonplaceholder.typicode.com';

  static Future<Post> createPost(Post post) async {
    final uri = Uri.parse('$_baseUrl/posts');
    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(post.toJson()),
    );

    if (response.statusCode == 201) {
      return Post.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Lỗi tạo bài viết: ${response.statusCode}');
    }
  }
}