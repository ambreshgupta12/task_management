import 'package:flutter/material.dart';
import 'package:task_manager/src/constants/color_constants.dart';
import 'package:task_manager/src/constants/route_path.dart';
import 'package:task_manager/src/constants/string_constants.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(KString.taskList),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: KColors.deepPurple,
          tooltip: KString.addTask,
          child: const Icon(
            Icons.add,
            color: KColors.whiteColor,
          ),
          onPressed: () => Navigator.of(context).pushNamed(
                RoutePath.addTaskScreen,
              )),
    );
  }
}
