import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.blue,
        appBar: AppBar(
          title: Text('Ask Me anything'),
          backgroundColor: Colors.blueGrey,
        ),
        body: Content(),
      ),
    ),
  );
}

class Content extends StatefulWidget {
  const Content({super.key});

  @override
  State<Content> createState() => _ContentState();
}

class _ContentState extends State<Content> {
  int value = Random().nextInt(5) + 1;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        children: [
          Expanded(
            child: TextButton(
              onPressed: () {
                setState(() {
                  value = Random().nextInt(5) + 1;
                });
              },
              child: Image.asset('images/ball$value.png'),
            ),
          ),
        ],
      ),
    );
  }
}
