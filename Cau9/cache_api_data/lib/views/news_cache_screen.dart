import 'package:flutter/material.dart';
import '../controllers/article_controller.dart';
import '../widgets/cache_info_widget.dart';
import '../widgets/article_item_widget.dart';

class NewsCacheScreen extends StatefulWidget {
  const NewsCacheScreen({super.key});

  @override
  State<NewsCacheScreen> createState() => _NewsCacheScreenState();
}

class _NewsCacheScreenState extends State<NewsCacheScreen> {
  final _controller = ArticleController();
  late Future<void> _loadFuture;

  @override
  void initState() {
    super.initState();
    _loadFuture = _controller.loadArticles();
  }

  Future<void> _refresh() async {
    await _controller.forceRefresh();
    setState(() {});
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Đã tải dữ liệu mới từ API'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tin Tức (Cache)'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _refresh,
            tooltip: 'Làm mới (xóa cache)',
          ),
        ],
      ),
      body: FutureBuilder(
        future: _loadFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 12),
                  Text('Đang tải dữ liệu...'),
                ],
              ),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error, color: Colors.red, size: 60),
                  Text('Lỗi: ${snapshot.error}'),
                  ElevatedButton(
                    onPressed: () =>
                        setState(() => _loadFuture = _controller.loadArticles()),
                    child: const Text('Thử lại'),
                  ),
                ],
              ),
            );
          }

          return Column(
            children: [
              CacheInfoWidget(
                fromCache: _controller.fromCache,
                cacheTime: _controller.cacheTime,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: _controller.articles.length,
                  itemBuilder: (ctx, i) =>
                      ArticleItemWidget(article: _controller.articles[i]),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}