import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/todo_model.dart';

class TodoApiService {
  static const String _base = 'https://jsonplaceholder.typicode.com';

  static Future<List<Todo>> fetchTodos() async {
    final response = await http.get(Uri.parse('$_base/todos?_limit=15'));
    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((e) => Todo.fromJson(e)).toList();
    }
    throw Exception('Không tải được danh sách');
  }

  static Future<bool> deleteTodo(int id) async {
    final response = await http.delete(Uri.parse('$_base/todos/$id'));
    return response.statusCode == 200;
  }
}