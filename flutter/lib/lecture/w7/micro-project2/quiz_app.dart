import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:week3/lecture/w7/micro-project2/model/submission.dart';
import 'package:week3/lecture/w7/micro-project2/screens/question_screen.dart';
import 'package:week3/lecture/w7/micro-project2/screens/result_screen.dart';
import 'package:week3/lecture/w7/micro-project2/screens/welcome_screen.dart';
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
  int currentQuestionIndex = 0;
  Submission submission = Submission(answers: []);

  // void switchScreen() {
  //   setState(() {
  //     switch (currentScreen) {
  //       case QuizState.notStart:
  //         currentScreen = QuizState.started;
  //         break;
  //       case QuizState.started:
  //         currentScreen = QuizState.finished;
  //         break;
  //       case QuizState.finished:
  //         currentScreen = QuizState.notStart;
  //         break;
  //     }
  //   });
  // }

  void startQuiz() {
    setState(() {
      currentScreen = QuizState.started;
      currentQuestionIndex = 0;
    });
  }

  void answerQuestion(String choice) {
    setState(() {
      submission.addAnswer(
        widget.quiz.questions[currentQuestionIndex], 
        choice, 
      );
       if (currentQuestionIndex == widget.quiz.questions.length - 1) {
        currentScreen = QuizState.finished;
      } else {
        currentQuestionIndex++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget screens = const Text("unknow screen");

    if (currentScreen == QuizState.notStart) {
      screens = WelcomeScreen(quizTitle: "Crazy Quiz", onStart: startQuiz);
    } else if (currentScreen == QuizState.started) {
      screens = QuestionScreen(onTap: answerQuestion, question: widget.quiz.questions[currentQuestionIndex]);
    } else if (currentScreen == QuizState.finished) {
      screens = ResultScreen();
    } else {
      const Text("unknow screen");
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
