import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
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

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
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
                      return Text("loading");
                    }
                  })
            ],
          ),
        ),
      )
    );
  }
}
