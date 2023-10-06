import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_provider/ViewModel/todo_provider.dart';

class DialogBox extends StatelessWidget {
  final TextEditingController controller;
  VoidCallback onSave;
  VoidCallback onCancel;

  DialogBox({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<TodoProvider>(
      builder: (context, value, child) => AlertDialog.adaptive(
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: "New task",
          ),
        ),
        alignment: Alignment.bottomCenter,
        actions: [
          TextButton(
            onPressed: onSave,
            child: const Text("Save"),
          ),
        ],
        insetPadding: EdgeInsets.zero,
        clipBehavior: Clip.hardEdge,
      ),
    );
  }
}
