import 'package:flutter/material.dart';
import 'package:week3/lecture/w7/micro-project2/model/quiz.dart';

class QuestionScreen extends StatelessWidget {
  final void Function (String choice) onTap;
  final Question question;
  const QuestionScreen({required this.onTap , required this.question , super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            question.title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          ...question.possibleAnswers.map((answer) {
            return SizedBox(
              width: 300,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ElevatedButton(
                  onPressed: () => onTap(answer),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 9, 143, 233),
                    foregroundColor: Colors.white,
                  ),
                  child: Text(answer),
                ),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}
