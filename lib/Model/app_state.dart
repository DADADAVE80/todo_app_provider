import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart'
    hide EmailAuthProvider, PhoneAuthProvider;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app_provider/Model/todo_model.dart';

import '../firebase_options.dart';

class ApplicationState extends ChangeNotifier {
  ApplicationState() {
    init();
  }

  bool _loggedIn = false;

  bool get loggedIn => _loggedIn;

  StreamSubscription<QuerySnapshot>? _todoSubscription;
  List<Todo> _todoList = [];
  List<Todo> get todoList => _todoList;

  Future<void> init() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);

    FirebaseUIAuth.configureProviders([
      EmailAuthProvider(),
    ]);

    FirebaseAuth.instance.userChanges().listen((user) {
      if (user != null) {
        _loggedIn = true;
        _todoSubscription = FirebaseFirestore.instance
            .collection('Todos')
            .orderBy('timestamp', descending: true)
            .snapshots()
            .listen((snapshot) {
              _todoList = [];
              for (final document in snapshot.docs) {
                _todoList.add(
                  Todo(task: document.data()['task'] as String,
                    completed: document.data()['completed'] as bool,
                  ),
                );
              }
              notifyListeners();
        });
      } else {
        _loggedIn = false;
        _todoList = [];
        _todoSubscription?.cancel();
      }
      notifyListeners();
    });
  }

  Future<DocumentReference> addTodoToFirebase(Todo todo){
    if (!_loggedIn) {
      throw Exception('Must be logged in');
    }

    return FirebaseFirestore.instance
        .collection('Todos')
        .add({
      'task': todo.task,
      'completed': todo.completed,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      'name': FirebaseAuth.instance.currentUser!.displayName,
      'userId': FirebaseAuth.instance.currentUser!.uid,
    }
    );
  }
}
