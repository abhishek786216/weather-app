import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'home.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TaskData(),
      child: MaterialApp(debugShowCheckedModeBanner: false, home: TaskScreen()),
    );
  }
}

// task_data.dart (Provider data)
class TaskData extends ChangeNotifier {
  List<Task> tasks = [Task(text: 'Set Goal DSA')];
  TaskData() {
    loadTasks(); // Load when initialized
  }

  int get taskCount => tasks.length;

  void addTask(String taskText) {
    tasks.add(Task(text: taskText));
    saveTasks();
    notifyListeners();
  }

  void updateTask(int index, bool? isChecked) {
    tasks[index].isCheck = isChecked ?? false;
    saveTasks();
    notifyListeners();
  }

  void delete(int index) {
    tasks.removeAt(index);
    saveTasks();
    notifyListeners();
  }

  Future<void> saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final taskJsonList = tasks
        .map((task) => jsonEncode(task.toJson()))
        .toList();
    prefs.setStringList('tasks', taskJsonList);
  }

  Future<void> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final taskJsonList = prefs.getStringList('tasks') ?? [];
    tasks = taskJsonList
        .map((taskJson) => Task.fromJson(jsonDecode(taskJson)))
        .toList();
    notifyListeners();
  }
}
