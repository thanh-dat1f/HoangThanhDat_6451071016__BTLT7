import 'package:flutter/material.dart';
import '../controllers/post_controller.dart';
import '../models/post_model.dart';
import '../widgets/post_form_widget.dart';
import '../widgets/post_result_widget.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();
  final _controller = PostController();

  bool _isLoading = false;
  Post? _createdPost;

  Future<void> _handleSubmit() async {
    setState(() => _isLoading = true);
    try {
      final post = await _controller.createPost(
        title: _titleController.text,
        body: _bodyController.text,
      );
      setState(() => _createdPost = post);
      _titleController.clear();
      _bodyController.clear();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Bài viết đã được tạo thành công!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Lỗi: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tạo Bài Viết Mới'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            PostFormWidget(
              titleController: _titleController,
              bodyController: _bodyController,
              isLoading: _isLoading,
              onSubmit: _handleSubmit,
            ),
            if (_createdPost != null) PostResultWidget(post: _createdPost!),
          ],
        ),
      ),
    );
  }
}