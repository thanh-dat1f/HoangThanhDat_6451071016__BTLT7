import '../models/user_model.dart';
import '../services/user_service.dart';

class UserRepository {
  const UserRepository({UserService? service})
    : _service = service ?? const UserService();

  final UserService _service;

  Future<List<UserModel>> fetchUsers() async {
    final usersRaw = await _service.fetchUsersRaw();
    return usersRaw
        .whereType<Map<String, dynamic>>()
        .map(UserModel.fromJson)
        .toList();
  }
}
