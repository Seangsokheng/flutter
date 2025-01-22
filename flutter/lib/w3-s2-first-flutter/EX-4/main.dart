// Start from the exercice 3 code
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Container(
      color: const Color(0xffE0E0E0),
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomCard(color: Color(0xffBBDEFB), text: "OOP"),
          CustomCard(color: Color(0xff64B5F6), text: "Dart"),
          CustomCard(
            gradient: LinearGradient(
              colors: [Color(0xff64B5F6), Color(0xff2C126D)],
            ),
            text: "Flutter"),
        ],
      )
    ),
  ));
}

class CustomCard extends StatelessWidget {
  final String text;
  final Color? color;
  final Gradient? gradient;
  const CustomCard({
    this.gradient,
    this.color,
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      width: 1000, // Set uniform width for all containers
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        color: color,
        gradient: gradient,
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            decoration: TextDecoration.none,
            color: Color(0xffFDFEFF),
          ),
        ),
      ),
    );
  }
}
