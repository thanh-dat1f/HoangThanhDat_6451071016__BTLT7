class Article {
  final int id;
  final String title;
  final String body;
  final int userId;

  Article({
    required this.id,
    required this.title,
    required this.body,
    required this.userId,
  });

  factory Article.fromJson(Map<String, dynamic> json) => Article(
    id: json['id'],
    title: json['title'] ?? '',
    body: json['body'] ?? '',
    userId: json['userId'] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'body': body,
    'userId': userId,
  };
}