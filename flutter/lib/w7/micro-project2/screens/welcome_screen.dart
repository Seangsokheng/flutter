import 'package:flutter/material.dart';

 class WelcomeScreen extends StatelessWidget {
  final String quizTitle;
  final VoidCallback onStart;
  
  const WelcomeScreen({required this.quizTitle , required this.onStart ,super.key});
   
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset('assets/microProject2/quiz-logo.png', width: 300),
          const SizedBox(height: 40),
          Text(
            quizTitle,
            style:const TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 40),
          OutlinedButton.icon(
            onPressed: onStart,
            style: OutlinedButton.styleFrom(
              backgroundColor: Colors.white,
            ),
            icon: const Icon(Icons.arrow_right_alt),
            label: const Text('Start Quiz'),
          ),
        ],
      ),
    );
  }
}
 
