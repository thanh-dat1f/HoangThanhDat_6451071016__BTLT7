import '../models/product_model.dart';
import '../utils/api_service.dart';

class ProductController {
  Future<Product> getProduct(int id) async {
    try {
      return await ApiService.fetchProduct(id);
    } catch (e) {
      throw Exception('Không thể tải sản phẩm: $e');
    }
  }
}