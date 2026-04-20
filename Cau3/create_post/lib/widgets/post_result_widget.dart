import 'package:flutter/material.dart';
import '../models/post_model.dart';

class PostResultWidget extends StatelessWidget {
  final Post post;

  const PostResultWidget({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.green.shade50,
      margin: const EdgeInsets.only(top: 20),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.check_circle, color: Colors.green),
                const SizedBox(width: 8),
                const Text(
                  'Post created successfully!',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const Divider(),
            Text('ID: ${post.id}'),
            Text('Tiêu đề: ${post.title}'),
            Text('Nội dung: ${post.body}'),
            Text('User ID: ${post.userId}'),
          ],
        ),
      ),
    );
  }
}