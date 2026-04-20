import '../models/news_model.dart';
import '../utils/news_api_service.dart';

class NewsController {
  List<NewsPost> newsList = [];

  Future<void> refreshNews() async {
    newsList = await NewsApiService.fetchNews();
  }
}