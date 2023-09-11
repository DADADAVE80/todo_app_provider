class Todo {
  int id;
  String title;
  String value;
  bool completed;

  Todo({
    required this.id,
    required this.title,
    required this.value,
    required this.completed,
  });

  Map<String, dynamic> todoMap() => {
    "id": id,
    "title": title,
    "value": value,
    "completed": false
  };

  List<Todo> todoList = [];

  addTodo(context, index) {
    todoList[index]
  }
}
