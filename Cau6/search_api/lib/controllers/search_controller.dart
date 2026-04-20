import '../models/product_model.dart';
import '../utils/search_api_service.dart';

class ProductSearchController {
  List<Product> products = [];
  bool isLoading = false;

  Future<void> search(String keyword) async {
    isLoading = true;
    if (keyword.trim().isEmpty) {
      products = await SearchApiService.getAllProducts();
    } else {
      products = await SearchApiService.searchProducts(keyword.trim());
    }
    isLoading = false;
  }
}