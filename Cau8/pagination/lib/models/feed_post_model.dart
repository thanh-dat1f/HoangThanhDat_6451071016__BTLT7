class FeedPost {
  final int id;
  final String title;
  final String body;
  final int userId;

  FeedPost({
    required this.id,
    required this.title,
    required this.body,
    required this.userId,
  });

  factory FeedPost.fromJson(Map<String, dynamic> json) => FeedPost(
        id: json['id'],
        title: json['title'] ?? '',
        body: json['body'] ?? '',
        userId: json['userId'] ?? 0,
      );
}