import 'package:flutter/material.dart';
import 'screen2.dart';
import 'screen0.dart';

class Screen1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.red, title: Text('Screen 1')),
      body: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          child: Text('G Forwards TScreen 2'),
          onPressed: () {
            Navigator.pushNamed(context, '/first');
          },
        ),
      ),
    );
  }
}
