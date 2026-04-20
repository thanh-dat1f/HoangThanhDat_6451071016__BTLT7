import 'package:flutter/material.dart';
import '../controllers/search_controller.dart';
import '../widgets/search_bar_widget.dart';
import '../widgets/product_card_widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchCtrl = TextEditingController();
  final _controller = ProductSearchController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _performSearch('');
  }

  Future<void> _performSearch(String keyword) async {
    setState(() => _isLoading = true);
    try {
      await _controller.search(keyword);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Lỗi: $e')),
        );
      }
    }
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tìm Kiếm Sản Phẩm'),
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          AppSearchBar(
            controller: _searchCtrl,
            onChanged: _performSearch,
          ),
          if (_isLoading)
            const LinearProgressIndicator(color: Colors.purple)
          else
            const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: Row(
              children: [
                Text(
                  'Tìm thấy ${_controller.products.length} sản phẩm',
                  style: const TextStyle(color: Colors.grey, fontSize: 13),
                ),
              ],
            ),
          ),
          Expanded(
            child: _controller.products.isEmpty && !_isLoading
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.search_off, size: 60, color: Colors.grey),
                        Text('Không tìm thấy sản phẩm'),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: _controller.products.length,
                    itemBuilder: (ctx, i) =>
                        ProductCardWidget(product: _controller.products[i]),
                  ),
          ),
        ],
      ),
    );
  }
}