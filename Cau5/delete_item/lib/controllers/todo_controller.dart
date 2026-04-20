import '../models/todo_model.dart';
import '../utils/todo_api_service.dart';

class TodoController {
  List<Todo> todos = [];

  Future<void> loadTodos() async {
    todos = await TodoApiService.fetchTodos();
  }

  Future<bool> deleteTodo(int id) async {
    final success = await TodoApiService.deleteTodo(id);
    if (success) todos.removeWhere((t) => t.id == id);
    return success;
  }
}