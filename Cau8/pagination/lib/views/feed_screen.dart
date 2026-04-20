import 'package:flutter/material.dart';
import '../controllers/feed_controller.dart';
import '../widgets/feed_post_widget.dart';
import '../widgets/loading_footer_widget.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final _controller = FeedController();
  final _scrollController = ScrollController();
  bool _initialLoading = true;

  @override
  void initState() {
    super.initState();
    _loadFirst();
    _scrollController.addListener(_onScroll);
  }

  Future<void> _loadFirst() async {
    await _controller.loadFirstPage();
    setState(() => _initialLoading = false);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      _loadMore();
    }
  }

  Future<void> _loadMore() async {
    if (_controller.isLoading || !_controller.hasMore) return;
    await _controller.loadNextPage();
    setState(() {});
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feed (${_controller.posts.length} bài)'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: _initialLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              controller: _scrollController,
              itemCount: _controller.posts.length + 1,
              itemBuilder: (ctx, index) {
                if (index == _controller.posts.length) {
                  return LoadingFooterWidget(hasMore: _controller.hasMore);
                }
                return FeedPostWidget(post: _controller.posts[index]);
              },
            ),
    );
  }
}