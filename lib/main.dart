import 'package:flutter/material.dart';
import 'package:tasksapp/presentaion/screens/mainscreen.dart';

void main() {
  runApp(const Tasks());
}

class Tasks extends StatefulWidget {
  const Tasks({Key? key}) : super(key: key);

  @override
  State<Tasks> createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        
        
      debugShowCheckedModeBanner: false,
      home: TasksScreen(),
    );
  }
}
