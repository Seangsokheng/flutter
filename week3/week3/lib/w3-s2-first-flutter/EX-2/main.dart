import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Container(
      color: const Color(0xff64B5F6),
      padding: const EdgeInsets.all(40),
      margin: const EdgeInsets.all(50),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          color: const Color(0xff1E88E5),
        ),
        child:const Center(
          child: Text(
            "CADT STUDENTS",
            style: TextStyle(
              fontSize: 50,
              decoration: TextDecoration.none,
              color: Color(0xffFDFEFF),
            ),
          ),
        ),
      ),
    ),
  ));
}
