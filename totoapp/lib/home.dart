import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'main.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  String userTask = '';

  Widget buildBottomSheet(BuildContext context) {
    return Container(
      color: const Color(0xff757575),
      child: Container(
        padding: MediaQuery.of(context).viewInsets,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 16),
            const Text(
              'Add Task',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30,
                color: Colors.lightBlueAccent,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                onChanged: (v) {
                  userTask = v;
                },
                autofocus: true,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: 'Enter your task',
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 20,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: const BorderSide(
                      color: Colors.lightBlueAccent,
                      width: 2.0,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            TextButton(
              onPressed: () {
                if (userTask.trim().isNotEmpty) {
                  Provider.of<TaskData>(
                    context,
                    listen: false,
                  ).addTask(userTask.trim());
                  Navigator.pop(context);
                }
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.lightBlueAccent,
                padding: const EdgeInsets.symmetric(vertical: 14.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              child: const Text(
                "ADD",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int noTask = Provider.of<TaskData>(context).taskCount;

    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: buildBottomSheet,
          );
        },
        backgroundColor: Colors.lightBlueAccent,
        child: const Icon(Icons.add),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(
              top: 60,
              left: 30,
              right: 30,
              bottom: 30,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  child: Icon(
                    Icons.list,
                    size: 30,
                    color: Colors.lightBlueAccent,
                  ),
                  backgroundColor: Colors.white,
                  radius: 30,
                ),
                const SizedBox(height: 10),
                const Text(
                  'Today',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 50,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  "${Provider.of<TaskData>(context).taskCount} tasks",
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: TaskList(),
            ),
          ),
        ],
      ),
    );
  }
}

// Task class
class Task {
  String text;
  bool isCheck;

  Task({required this.text, this.isCheck = false});

  // Convert Task to JSON
  Map<String, dynamic> toJson() => {'text': text, 'isCheck': isCheck};

  // Create Task from JSON
  factory Task.fromJson(Map<String, dynamic> json) =>
      Task(text: json['text'], isCheck: json['isCheck']);
}

// Task List
class TaskList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(
      builder: (context, taskData, child) {
        return ListView.builder(
          itemCount: taskData.tasks.length,
          itemBuilder: (context, index) {
            return TaskTile(
              task: taskData.tasks[index],
              toggle: (bool? value) {
                taskData.updateTask(index, value);
              },
              Longpress: () {
                taskData.delete(index);
              },
            );
          },
        );
      },
    );
  }
}

// Task Tile
class TaskTile extends StatelessWidget {
  final Task task;
  final Function(bool?) toggle;
  final VoidCallback Longpress;

  const TaskTile({
    required this.task,
    required this.toggle,
    required this.Longpress,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        task.text,
        style: TextStyle(
          decoration: task.isCheck
              ? TextDecoration.lineThrough
              : TextDecoration.none,
        ),
      ),
      onLongPress: Longpress,
      trailing: Checkbox(
        value: task.isCheck,
        activeColor: Colors.lightBlueAccent,
        onChanged: toggle,
      ),
    );
  }
}
