import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product_model.dart';

class ApiService {
  static const String _baseUrl = 'https://fakestoreapi.com';

  static Future<Product> fetchProduct(int id) async {
    final uri = Uri.parse('$_baseUrl/products/$id');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return Product.fromJson(json);
    } else {
      throw Exception('Lỗi tải sản phẩm: ${response.statusCode}');
    }
  }
}