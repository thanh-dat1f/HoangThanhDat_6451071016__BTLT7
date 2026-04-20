import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product_model.dart';

class SearchApiService {
  static Future<List<Product>> searchProducts(String keyword) async {
    // FakeStore API không hỗ trợ query search,
    // dùng DummyJSON API hỗ trợ q param
    final uri = Uri.parse(
        'https://dummyjson.com/products/search?q=${Uri.encodeComponent(keyword)}');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List products = data['products'] ?? [];
      return products.map((e) => Product.fromJson(e)).toList();
    }
    throw Exception('Lỗi tìm kiếm: ${response.statusCode}');
  }

  static Future<List<Product>> getAllProducts() async {
    final uri = Uri.parse('https://dummyjson.com/products?limit=20');
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List products = data['products'] ?? [];
      return products.map((e) => Product.fromJson(e)).toList();
    }
    throw Exception('Lỗi tải sản phẩm');
  }
}