import 'package:flutter/material.dart';

 class WelcomeScreen extends StatelessWidget {
  final String quizTitle;
  final VoidCallback onStart;
  
  const WelcomeScreen({required this.quizTitle , required this.onStart ,super.key});
   
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue, 
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.question_mark, 
              size: 100,
              color: Colors.white,
            ),
            const SizedBox(height: 20),  
            Text(
              quizTitle, 
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 40), 

            ElevatedButton.icon(
              onPressed: onStart, 
              icon: const Icon(Icons.arrow_forward, color: Colors.white),
              label:const Text(
                "Start Quiz",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
 
