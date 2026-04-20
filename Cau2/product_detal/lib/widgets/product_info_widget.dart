import 'package:flutter/material.dart';
import '../models/product_model.dart';

class ProductInfoWidget extends StatelessWidget {
  final Product product;

  const ProductInfoWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Hình ảnh sản phẩm
          Center(
            child: Image.network(
              product.image,
              height: 250,
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) =>
                  const Icon(Icons.broken_image, size: 100),
            ),
          ),
          const SizedBox(height: 16),

          // Tên sản phẩm
          Text(
            product.title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),

          // Danh mục
          Chip(
            label: Text(product.category),
            backgroundColor: Colors.blue.shade100,
          ),
          const SizedBox(height: 12),

          // Giá
          Text(
            '\$${product.price.toStringAsFixed(2)}',
            style: const TextStyle(
              fontSize: 26,
              color: Colors.green,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          // Mô tả
          const Text(
            'Mô tả sản phẩm:',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          Text(
            product.description,
            style: const TextStyle(fontSize: 14, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}