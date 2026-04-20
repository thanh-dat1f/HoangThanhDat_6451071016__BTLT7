import 'package:flutter/material.dart';

class LoadingFooterWidget extends StatelessWidget {
  final bool hasMore;

  const LoadingFooterWidget({super.key, required this.hasMore});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      alignment: Alignment.center,
      child: hasMore
          ? const CircularProgressIndicator()
          : const Text(
              'Đã tải hết dữ liệu',
              style: TextStyle(color: Colors.grey),
            ),
    );
  }
}
