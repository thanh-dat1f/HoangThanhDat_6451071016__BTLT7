import '../data/models/user_model.dart';
import '../data/repository/user_repository.dart';

class UserController {
  const UserController({UserRepository? repository})
    : _repository = repository ?? const UserRepository();

  final UserRepository _repository;

  Future<List<UserModel>> fetchUsers() {
    return _repository.fetchUsers();
  }
}
