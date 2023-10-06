import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_provider/Model/todo_model.dart';
import 'package:todo_app_provider/View/create_task.dart';
import 'package:todo_app_provider/Widgets/dialog_box.dart';
import 'package:todo_app_provider/Widgets/task_tile.dart';
import 'package:todo_app_provider/ViewModel/todo_provider.dart';

class TodoHomePage extends StatelessWidget {
  const TodoHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final todoProvider = Provider.of<TodoProvider>(context);

    final controller = TextEditingController();

    void saveNewTask() {
      todoProvider.addTodo(
        Todo(
          task: controller.text,
          completed: false,
        ),
      );
      Navigator.of(context).pop();
    }

    void createNewTask() {
      showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
            controller: controller,
            onSave: saveNewTask,
            onCancel: () => Navigator.of(context).pop(),
          );
        },
      );
    }

    void deleteTask(int index) {
      todoProvider.todoList.removeAt(index);
    }

    return Consumer<TodoProvider>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              const Expanded(
                flex: 1,
                child: Text(
                  'To-dos',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
              ),
              CircleAvatar(
                child: GestureDetector(
                  onTap: () => context.push('/sign-in'),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: createNewTask,
          label: IntrinsicWidth(
            child: Row(
              children: [
                const Text("Add Task"),
                const SizedBox(
                  width: 5,
                ),
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.add),
                )
              ],
            ),
          ),
        ),
        body: FutureBuilder(
          future: FirebaseFirestore.instance
              .collection("Todos")
              .get()
              .then((snapshot) => snapshot.docs.forEach((element) {
            if (kDebugMode) {
              print(element.reference);
            }
          })),
          builder: (context, snapshot) {
            if (value.todoList.isEmpty) {
              return const Center(
                child: Text(
                  "No tasks yet",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 24,
                  ),
                ),
              );
            }
            return RefreshIndicator(
              onRefresh: _pullRefresh,
              child: ListView.separated(
                itemBuilder: (context, index) => TodoTile(
                  taskName: value.todoList[index].task,
                  taskCompleted: value.todoList[index].completed,
                  onChanged: (value) =>
                      todoProvider.onTaskComplete(value, index),
                  onDelete: (context) => deleteTask(index),
                ),
                separatorBuilder: (context, index) => const SizedBox(),
                itemCount: value.todoList.length,
              ),
            );
          },
        ),
      ),
    );
  }

  // Fix: Removed unnecessary `async` keyword from the `_pullRefresh` method.
  Future<void> _pullRefresh() async {
    // TODO: Implement the pull-to-refresh logic here.
  }
}
