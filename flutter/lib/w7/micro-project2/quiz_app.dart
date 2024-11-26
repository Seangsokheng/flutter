import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:week3/w7/micro-project2/screens/question_screen.dart';
import 'package:week3/w7/micro-project2/screens/result_screen.dart';
import 'package:week3/w7/micro-project2/screens/welcome_screen.dart';
import 'model/quiz.dart';

Color appColor = Colors.blue[500] as Color;

enum QuizState {
  notStart,
  started,
  finished,
}

class QuizApp extends StatefulWidget {
  const QuizApp(this.quiz, {super.key});

  final Quiz quiz;

  @override
  State<QuizApp> createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  QuizState currentScreen = QuizState.notStart;

  void switchScreen() {
    setState(() {
      switch (currentScreen) {
        case QuizState.notStart:
          currentScreen = QuizState.started;
          break;
        case QuizState.started:
          currentScreen = QuizState.finished;
          break;
        case QuizState.finished:
          currentScreen = QuizState.notStart;
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget screens = Text("unknow screen");
    ;

    if (currentScreen == QuizState.notStart) {
      screens = WelcomeScreen(quizTitle: "Crazy Quiz", onStart: switchScreen);
    } else if (currentScreen == QuizState.started) {
      screens = QuestionScreen();
    } else if (currentScreen == QuizState.finished) {
      screens = ResultScreen();
    } else {
      Text("unknow screen");
    }

    return MaterialApp(
      home: Scaffold(
        backgroundColor: appColor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              screens,
            ],
          ),
        ),
      ),
    );
  }
}
