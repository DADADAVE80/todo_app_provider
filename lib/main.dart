import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_provider/ViewModel/todo_provider.dart';

import 'View/todoHomepage.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => TodoProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const TodoHomePage(),
    );
  }
}
