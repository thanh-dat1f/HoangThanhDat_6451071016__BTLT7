import '../models/user_model.dart';
import '../utils/user_api_service.dart';

class UserController {
  Future<User> loadUser(int id) => UserApiService.fetchUser(id);

  Future<User> updateUser(int id, User user) =>
      UserApiService.updateUser(id, user);

  void validateUser(User user) {
    if (user.name.trim().isEmpty) throw Exception('Tên không được trống');
    if (user.email.trim().isEmpty) throw Exception('Email không được trống');
  }
}