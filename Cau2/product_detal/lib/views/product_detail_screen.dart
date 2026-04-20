import 'package:flutter/material.dart';
import '../controllers/product_controller.dart';
import '../models/product_model.dart';
import '../widgets/product_info_widget.dart';
import '../widgets/error_widget.dart';

class ProductDetailScreen extends StatefulWidget {
  final int productId;

  const ProductDetailScreen({super.key, required this.productId});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  late Future<Product> _productFuture;
  final ProductController _controller = ProductController();

  @override
  void initState() {
    super.initState();
    _loadProduct();
  }

  void _loadProduct() {
    setState(() {
      _productFuture = _controller.getProduct(widget.productId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chi Tiết Sản Phẩm'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder<Product>(
        future: _productFuture,
        builder: (context, snapshot) {
          // Loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // Lỗi
          if (snapshot.hasError) {
            return AppErrorWidget(
              message: snapshot.error.toString(),
              onRetry: _loadProduct,
            );
          }

          // Thành công
          if (snapshot.hasData) {
            return ProductInfoWidget(product: snapshot.data!);
          }

          return const Center(child: Text('Không có dữ liệu'));
        },
      ),
    );
  }
}