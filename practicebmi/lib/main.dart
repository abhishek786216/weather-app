import 'package:flutter/material.dart';
import 'content.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(), // Light theme
      darkTheme: ThemeData.dark(), // Dark theme
      themeMode: ThemeMode.dark,

      home: Scaffold(
        appBar: AppBar(title: Center(child: Text('BMI Index'))),
        body: Content(),
      ),
    );
  }
}
