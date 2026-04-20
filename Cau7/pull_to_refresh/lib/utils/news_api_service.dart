import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import '../models/news_model.dart';

class NewsApiService {
  static Future<List<NewsPost>> fetchNews() async {
    // Random start để mỗi lần refresh thấy dữ liệu khác
    final start = Random().nextInt(50) + 1;
    final response = await http.get(
      Uri.parse(
          'https://jsonplaceholder.typicode.com/posts?_start=$start&_limit=10'),
    );
    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((e) => NewsPost.fromJson(e)).toList();
    }
    throw Exception('Không tải được tin tức');
  }
}