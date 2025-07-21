import 'package:flutter/material.dart';
import 'content.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.dark, // Force dark mode
      darkTheme: ThemeData.dark(), // Apply dark theme
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: const Content(), // ← Your actual converter widget here
      ),
    );
  }
}
