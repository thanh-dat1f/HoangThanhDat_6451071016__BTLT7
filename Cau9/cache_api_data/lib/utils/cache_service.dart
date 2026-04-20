import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class CacheService {
  static const String _articlesKey = 'cached_articles';
  static const String _cacheTimeKey = 'cache_time';
  static const int _cacheMinutes = 5; // Cache 5 phút

  static Future<String?> getCachedData() async {
    final prefs = await SharedPreferences.getInstance();
    final cacheTime = prefs.getInt(_cacheTimeKey) ?? 0;
    final now = DateTime.now().millisecondsSinceEpoch;

    // Kiểm tra cache còn hạn không
    if (now - cacheTime < _cacheMinutes * 60 * 1000) {
      return prefs.getString(_articlesKey);
    }
    return null; // Cache hết hạn
  }

  static Future<void> saveData(String jsonData) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_articlesKey, jsonData);
    await prefs.setInt(
        _cacheTimeKey, DateTime.now().millisecondsSinceEpoch);
  }

  static Future<void> clearCache() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_articlesKey);
    await prefs.remove(_cacheTimeKey);
  }

  static Future<DateTime?> getCacheTime() async {
    final prefs = await SharedPreferences.getInstance();
    final time = prefs.getInt(_cacheTimeKey);
    if (time == null) return null;
    return DateTime.fromMillisecondsSinceEpoch(time);
  }
}