import '../models/post_model.dart';
import '../utils/post_api_service.dart';

class PostController {
  bool isLoading = false;
  String? errorMessage;
  Post? createdPost;

  Future<Post?> createPost({
    required String title,
    required String body,
  }) async {
    if (title.trim().isEmpty || body.trim().isEmpty) {
      throw Exception('Tiêu đề và nội dung không được để trống');
    }

    final post = Post(title: title.trim(), body: body.trim(), userId: 1);
    return await PostApiService.createPost(post);
  }
}