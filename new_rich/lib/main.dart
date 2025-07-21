import 'package:flutter/material.dart';

//This is main function starting with here any app
void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('I Am Rich'),
          backgroundColor: Colors.blueGrey[900],
        ),
        backgroundColor: Colors.amber,
        body: Center(child: Image(image: AssetImage('images/diamond.png'))),
      ),
    ),
  );
}
