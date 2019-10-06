import 'package:flutter/material.dart';
import 'package:task_notes/homepage.dart';
import 'addTask.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: HomePage.id,
      routes: {
        HomePage.id: (context) => HomePage(),
        AddTask.id: (context) => AddTask(),
      },
    );
  }
}
