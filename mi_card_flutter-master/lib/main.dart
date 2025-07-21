import 'package:flutter/material.dart';

void main() {
  runApp(MyApp()); // Fixed: class name should match
}

class MyApp extends StatelessWidget {
  const MyApp({super.key}); // Class name corrected to PascalCase

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Teal Background App',
      debugShowCheckedModeBanner: false, // Removes debug banner
      home: Scaffold(
        backgroundColor: Colors.teal,
        body: Center(
          child: Text(
            'Hello, Flutter!',
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
