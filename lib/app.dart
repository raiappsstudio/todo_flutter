import 'package:flutter/material.dart';
import 'package:todo_flutter/screens/todo_list_sreens.dart';

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TodoListSreens(),
    );
  }
}
