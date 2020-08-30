import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(PhysicsProblems());
}

class PhysicsProblems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Problems in Physics',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ProblemPage(title: 'Problems in Physics'),
    );
  }
}

class ProblemPage extends StatefulWidget {
  ProblemPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ProblemPageState createState() => _ProblemPageState();
}

class _ProblemPageState extends State<ProblemPage> {
  Future<String> nextProblem() async {
    final problemsData =
        await DefaultAssetBundle.of(context).loadString("data/problems.json");
    final problems = jsonDecode(problemsData);
    final rng = new Random();
    final question = rng.nextInt(problems.length);
    final number = problems[question]['number'];
    final text = problems[question]['text'];
    return '$number. $text';
  }

  void nextQuestion() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FutureBuilder(
                  future: nextProblem(),
                  builder: (context, snapshot) {
                    if (snapshot.data != null) {
                      return Text(snapshot.data);
                    } else {
                      return CircularProgressIndicator();
                    }
                  })
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: nextQuestion,
        tooltip: 'Next Question',
        child: Icon(Icons.play_arrow),
      )
    );
  }
}
