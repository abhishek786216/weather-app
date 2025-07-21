import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  final String data = "hello wolrd";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Provider<String>(create: (context) => data, child: level1()),
    );
  }
}

class level1 extends StatelessWidget {
  const level1({super.key});

  @override
  Widget build(BuildContext context) {
    return level2();
  }
}

class level2 extends StatelessWidget {
  const level2({super.key});

  @override
  Widget build(BuildContext context) {
    return level3();
  }
}

class level3 extends StatelessWidget {
  const level3({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(Provider.of<String>(context)));
  }
}
