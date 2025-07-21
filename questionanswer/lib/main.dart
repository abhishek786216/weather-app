import 'package:flutter/material.dart';
import 'question.dart';

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> score = [];
  List<Question> allquestion = [
    Question(a: 'The capital of Australia is Sydney.', b: false),
    Question(a: 'The sun rises in the east.', b: true),
    Question(a: 'There are 365 days in a year.', b: true),
    Question(a: 'The chemical symbol for water is H2O.', b: true),
    Question(a: 'The square root of 16 is 5.', b: false),
    Question(a: 'The Great Wall of China is visible from space.', b: false),
    Question(a: 'Lightning never strikes the same place twice.', b: false),
    Question(a: 'Humans have walked on Mars.', b: false),
    Question(a: 'Sharks are mammals.', b: false),
    Question(a: 'Mount Everest is the tallest mountain on Earth.', b: true),
  ];

  int count = 0;

  void checkAnswer(bool userAnswer) {
    if (count < allquestion.length) {
      setState(() {
        bool correctAnswer = allquestion[count].answer;
        if (userAnswer == correctAnswer) {
          score.add(Icon(Icons.check, color: Colors.green, size: 30.0));
        } else {
          score.add(Icon(Icons.close, color: Colors.red, size: 30.0));
        }

        count++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                count < allquestion.length
                    ? allquestion[count].questionText
                    : 'Quiz Finished!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25.0, color: Colors.white),
              ),
            ),
          ),
        ),
        if (count < allquestion.length)
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: TextButton(
                style: TextButton.styleFrom(backgroundColor: Colors.green),
                child: Text(
                  'True',
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                ),
                onPressed: () {
                  checkAnswer(true);
                },
              ),
            ),
          ),
        if (count < allquestion.length)
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: TextButton(
                style: TextButton.styleFrom(backgroundColor: Colors.red),
                child: Text(
                  'False',
                  style: TextStyle(fontSize: 20.0, color: Colors.white),
                ),
                onPressed: () {
                  checkAnswer(false);
                },
              ),
            ),
          ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(children: score),
        ),
      ],
    );
  }
}
