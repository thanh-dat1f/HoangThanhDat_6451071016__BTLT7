import 'dart:convert';
import '../models/article_model.dart';
import '../utils/article_api_service.dart';
import '../utils/cache_service.dart';

class ArticleController {
  List<Article> articles = [];
  bool fromCache = false;
  DateTime? cacheTime;

  Future<void> loadArticles() async {
    // Thử load từ cache
    final cached = await CacheService.getCachedData();

    if (cached != null) {
      // Load từ cache
      final List data = jsonDecode(cached);
      articles = data.map((e) => Article.fromJson(e)).toList();
      fromCache = true;
      cacheTime = await CacheService.getCacheTime();
    } else {
      // Gọi API
      articles = await ArticleApiService.fetchArticles();
      fromCache = false;

      // Lưu vào cache
      final jsonStr =
      jsonEncode(articles.map((a) => a.toJson()).toList());
      await CacheService.saveData(jsonStr);
      cacheTime = DateTime.now();
    }
  }

  Future<void> forceRefresh() async {
    await CacheService.clearCache();
    articles = await ArticleApiService.fetchArticles();
    fromCache = false;
    cacheTime = DateTime.now();

    final jsonStr =
    jsonEncode(articles.map((a) => a.toJson()).toList());
    await CacheService.saveData(jsonStr);
  }
}