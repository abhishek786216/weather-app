import 'package:flutter/material.dart';
import 'input_page.dart';
import 'ans.dart'; // This should contain FinalAns widget

void main() => runApp(BMICalculator());

class BMICalculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: InputPage(),
    );
  }
}
