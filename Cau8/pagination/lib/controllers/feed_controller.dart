import '../models/feed_post_model.dart';
import '../utils/feed_api_service.dart';

class FeedController {
  final List<FeedPost> posts = [];
  int _currentPage = 1;
  bool isLoading = false;
  bool hasMore = true;

  Future<void> loadFirstPage() async {
    _currentPage = 1;
    posts.clear();
    hasMore = true;
    await _fetchPage();
  }

  Future<void> loadNextPage() async {
    if (isLoading || !hasMore) return;
    await _fetchPage();
  }

  Future<void> _fetchPage() async {
    isLoading = true;
    final newPosts = await FeedApiService.fetchPage(_currentPage);
    if (newPosts.isEmpty || newPosts.length < 10) {
      hasMore = false;
    }
    posts.addAll(newPosts);
    _currentPage++;
    isLoading = false;
  }
}