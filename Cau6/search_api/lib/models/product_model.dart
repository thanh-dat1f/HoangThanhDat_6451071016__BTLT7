class Product {
  final int id;
  final String title;
  final double price;
  final String image;
  final String category;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.image,
    required this.category,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json['id'] ?? 0,
        title: json['title'] ?? '',
        price: (json['price'] ?? 0).toDouble(),
        image: json['image'] ?? '',
        category: json['category'] ?? '',
      );
}