import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/feed_post_model.dart';

class FeedApiService {
  static const int _pageSize = 10;

  static Future<List<FeedPost>> fetchPage(int page) async {
    final start = (page - 1) * _pageSize;
    final uri = Uri.parse(
        'https://jsonplaceholder.typicode.com/posts?_start=$start&_limit=$_pageSize');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((e) => FeedPost.fromJson(e)).toList();
    }
    throw Exception('Lỗi tải trang $page');
  }
}