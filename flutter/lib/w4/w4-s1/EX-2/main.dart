import 'package:flutter/material.dart';

const String FireBase = "assets/w4-s1-ex/Firebase.jpg";
const String Dart = "assets/w4-s1-ex/Dart.jpg";
const String Flutter = "assets/w4-s1-ex/Flutter.jpg";
enum Dart {}
void main() {
  runApp(
    const MaterialApp(
      home: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [],
          ),
        ),
      ),
    ),
  );
}

class Card extends StatelessWidget {
  final String title;
  final String desc;
  final 
  const Card({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 80,
        width: 500,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Column(
            children: [
              Image.asset(
                Dart,
              ),
              Text(),
              Text(),
            ],
          ),
        ),
      ),
    );
  }
}
