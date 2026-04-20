import 'package:flutter/material.dart';

class CacheInfoWidget extends StatelessWidget {
  final bool fromCache;
  final DateTime? cacheTime;

  const CacheInfoWidget({
    super.key,
    required this.fromCache,
    this.cacheTime,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      color: fromCache ? Colors.amber.shade50 : Colors.green.shade50,
      child: Row(
        children: [
          Icon(
            fromCache ? Icons.storage : Icons.cloud_download,
            size: 18,
            color: fromCache ? Colors.orange : Colors.green,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              fromCache
                  ? 'Dữ liệu từ cache - ${_formatTime(cacheTime)}'
                  : 'Dữ liệu mới từ API',
              style: TextStyle(
                fontSize: 12,
                color: fromCache ? Colors.orange : Colors.green,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatTime(DateTime? time) {
    if (time == null) return '';
    return '${time.hour}:${time.minute.toString().padLeft(2, '0')}';
  }
}