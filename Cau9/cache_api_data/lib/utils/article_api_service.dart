import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/article_model.dart';

class ArticleApiService {
  static Future<List<Article>> fetchArticles() async {
    final response = await http.get(
      Uri.parse(
          'https://jsonplaceholder.typicode.com/posts?_limit=20'),
    );
    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((e) => Article.fromJson(e)).toList();
    }
    throw Exception('Lỗi tải bài viết');
  }
}