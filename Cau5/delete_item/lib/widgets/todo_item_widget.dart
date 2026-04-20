import 'package:flutter/material.dart';
import '../models/todo_model.dart';

class TodoItemWidget extends StatelessWidget {
  final Todo todo;
  final VoidCallback onDelete;

  const TodoItemWidget({
    super.key,
    required this.todo,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: todo.completed ? Colors.green : Colors.grey,
          child: Icon(
            todo.completed ? Icons.check : Icons.pending,
            color: Colors.white,
            size: 18,
          ),
        ),
        title: Text(
          todo.title,
          style: TextStyle(
            decoration: todo.completed ? TextDecoration.lineThrough : null,
            color: todo.completed ? Colors.grey : Colors.black,
          ),
        ),
        subtitle: Text('ID: ${todo.id}'),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: onDelete,
        ),
      ),
    );
  }
}