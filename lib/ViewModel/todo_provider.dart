import 'package:flutter/material.dart';
import 'package:todo_app_provider/Model/todo_model.dart';

class TodoProvider extends ChangeNotifier {
  Todo todo = Todo(task: "", completed: false);

  final List<Todo> _todoList = [];
  List<Todo> get todoList => _todoList;

  void addTodo(Todo todo) {
    todoList.add(todo);
    notifyListeners();
  }

  removeTodo(int index) {
    todoList.removeAt(index);
    notifyListeners();
  }

  void onTaskComplete(bool? value, int index) {
    todoList[index].completed = !todoList[index].completed;
    notifyListeners();
  }
}

