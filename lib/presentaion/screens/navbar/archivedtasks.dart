import 'package:flutter/material.dart';
import 'package:tasksapp/shared/strings.dart';

class ArchivedTasks extends StatefulWidget {
  const ArchivedTasks({Key? key}) : super(key: key);

  @override
  State<ArchivedTasks> createState() => _ArchivedTasksState();
}

class _ArchivedTasksState extends State<ArchivedTasks> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(archivedtasks),
    );
  }
}
