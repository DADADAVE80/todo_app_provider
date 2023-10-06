import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_provider/ViewModel/todo_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:todo_app_provider/Model/app_state.dart';
import 'package:todo_app_provider/firebase_options.dart';
import 'package:todo_app_provider/routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TodoProvider()),
        ChangeNotifierProvider(create: (context) => ApplicationState()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'TodoProvider App',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        useMaterial3: true,
      ),
      routerConfig: router,
    );
  }
}
