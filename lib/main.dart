import 'package:flutter/material.dart';
import 'package:taskapp/screens/addTask.dart';
import 'package:taskapp/screens/homeScreen.dart';

void main()
{
  runApp(TaskApp());
}
class TaskApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.deepPurple
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: HomeScreen.id,
      routes: {
        HomeScreen.id:(context)=>HomeScreen(),
        AddTaskScreen.id:(context)=>AddTaskScreen()
      },
    );
  }
}
