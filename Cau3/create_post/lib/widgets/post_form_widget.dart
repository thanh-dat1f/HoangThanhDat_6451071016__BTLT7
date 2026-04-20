
import 'package:flutter/material.dart';

class PostFormWidget extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController bodyController;
  final bool isLoading;
  final VoidCallback onSubmit;

  const PostFormWidget({
    super.key,
    required this.titleController,
    required this.bodyController,
    required this.isLoading,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: titleController,
          decoration: InputDecoration(
            labelText: 'Tiêu đề bài viết',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            prefixIcon: const Icon(Icons.title),
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: bodyController,
          maxLines: 5,
          decoration: InputDecoration(
            labelText: 'Nội dung bài viết',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            prefixIcon: const Icon(Icons.article),
            alignLabelWithHint: true,
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton.icon(
          onPressed: isLoading ? null : onSubmit,
          icon: isLoading
              ? const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Icon(Icons.send),
          label: Text(isLoading ? 'Đang gửi...' : 'Đăng bài'),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 14),
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
          ),
        ),
      ],
    );
  }
}