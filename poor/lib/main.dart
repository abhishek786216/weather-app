import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('I am poor'),
          backgroundColor: Colors.grey[500],
        ),

        backgroundColor: Colors.pink,
        body: Center(child: Image(image: AssetImage('images/logo.jpg'))),
      ),
    ),
  );
}
