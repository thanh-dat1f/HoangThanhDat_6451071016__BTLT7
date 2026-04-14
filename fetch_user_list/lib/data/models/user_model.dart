class UserModel {
  final int id;
  final String name;
  final String email;

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final firstName = (json['firstName'] ?? '').toString().trim();
    final lastName = (json['lastName'] ?? '').toString().trim();
    final fallbackFullName = '$firstName $lastName'.trim();

    return UserModel(
      id: (json['id'] as num).toInt(),
      name: (json['name'] ?? fallbackFullName).toString(),
      email: (json['email'] ?? '').toString(),
    );
  }
}
