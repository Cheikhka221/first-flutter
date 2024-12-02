import 'package:flutter/material.dart';
import 'package:first_flutter_eval/pages/task_list.dart';
import 'package:first_flutter_eval/pages/task_form.dart';
import 'package:first_flutter_eval/pages/task_details.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gestion des Tâches',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const TaskListPage(),
        '/task-form': (context) => const TaskFormPage(),
        '/task-list': (context) => const TaskListPage(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/task-details') {
          final args = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (context) {
              return TaskDetailsPage(task: args['task']);
            },
          );
        }
        return null;
      },
    );
  }
}