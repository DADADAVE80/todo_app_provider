import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_provider/View/create_todo.dart';
import 'package:todo_app_provider/ViewModel/todo_provider.dart';

class TodoHomePage extends StatelessWidget {
  const TodoHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("To-do app"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CreateTodoPage(),
            ),
          );
        },
        child: const Text("Add Todo"),
      ),
      body: SafeArea(
        child: Consumer<TodoProvider>(
          builder: (context, cp, child) => ListView.separated(
              itemBuilder: (context, index) => CheckboxListTile(
                    value: value,
                    onChanged: onChanged,
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
              separatorBuilder: (context, index) => const Padding(
                    padding: EdgeInsets.all(8),
                    child: Divider(height: 0),
                  ),
              itemCount: itemCount),
        ),
      ),
    );
  }
}
