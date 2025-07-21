import 'package:flutter/material.dart';

void main() {
  runApp(MyApp()); // Class name matches
}

class MyApp extends StatelessWidget {
  const MyApp({super.key}); // Optional but recommended

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.teal,
        body: SafeArea(
          child: Column(
            // mainAxisSize: MainAxisSize.min,
            // backgroundColor:Colors.pink,
            // verticalDirection: VerticalDirection.up,
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                height: 100,
                width: 100,
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                color: Colors.blue,
                child: const Center(
                  child: Text(
                    'hello',
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                ),
              ),
              SizedBox(height: 100),
              Container(
                height: 100,
                width: 100,
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                color: Colors.red,
                child: const Center(
                  child: Text(
                    'hello',
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                ),
              ),
              Container(
                height: 100,
                width: 100,
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                color: Colors.white,
                child: const Center(
                  child: Text(
                    'hello',
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                ),
              ),
              Container(width: double.infinity),
            ],
          ),
        ),
      ),
    );
  }
}
