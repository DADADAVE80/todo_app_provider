class Todo {
  String task;
  bool completed;

  Todo({
    required this.task,
    required this.completed,
  });

  Map<String, dynamic> toMap() {
    return {
      "task": task,
      "completed": completed,
    };
  }

  factory Todo.fromMap(Map map) {
    return Todo(
      task: map["task"],
      completed: map["completed"],
    );
  }

  final List<Todo> _todos = [];

  void addAndStoreTodo(Todo todo) {
    _todos.add(todo);
  }

  void removeTodo(List<Todo> todoList, int index) {
    todoList.removeAt(index);
  }

  void onTaskComplete(bool? value, int index) {
    _todos[index].completed = !_todos[index].completed;
  }

  @override
  String toString() {
    return 'Todo: $task isCompleted: $completed';
  }
}
