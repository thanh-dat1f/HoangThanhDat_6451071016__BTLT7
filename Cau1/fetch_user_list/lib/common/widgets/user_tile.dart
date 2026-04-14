import 'package:flutter/material.dart';

import '../../data/models/user_model.dart';

class UserTile extends StatelessWidget {
  const UserTile({super.key, required this.user});

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: Text(user.id.toString()),
      ),
      title: Text(user.name),
      subtitle: Text(user.email),
    );
  }
}
