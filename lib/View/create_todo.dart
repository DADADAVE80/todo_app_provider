import 'package:flutter/material.dart';

class CreateTodoPage extends StatelessWidget {
  const CreateTodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AlertDialog(
      content: SingleChildScrollView(
        child: TextField(),
      ),
    );
  }
}