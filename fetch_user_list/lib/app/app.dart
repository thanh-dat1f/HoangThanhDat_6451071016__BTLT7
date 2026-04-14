import 'package:flutter/material.dart';

import '../common/styles/app_theme.dart';
import '../controllers/user_controller.dart';
import 'user_list_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key, UserController? controller})
    : _controller = controller ?? const UserController();

  final UserController _controller;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch User List',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: UserListPage(controller: _controller),
    );
  }
}
