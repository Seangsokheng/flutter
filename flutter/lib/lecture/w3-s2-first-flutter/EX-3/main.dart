import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Container(
      color: const Color(0xffE0E0E0),
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 20),
            width: 1000, // Set uniform width for all containers
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color:const Color(0xffBBDEFB),
            ),
            child: const Center(
              child: Text(
            "OOP",
            style: TextStyle(
              decoration: TextDecoration.none,
              color: Color(0xffFDFEFF),
            ),
            ),
            ),  
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 20),
            width: 1000, 
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color:const Color(0xff64B5F6),
            ),
            child: const Center(
              child:  Text(
              "Dart",
              style: TextStyle(
                decoration: TextDecoration.none,
                color: Color(0xffFDFEFF),
              ),
            ),
            )
            
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 20),
            width: 1000, // Set uniform width for all containers
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              gradient :const LinearGradient(
                colors:[Color(0xff64B5F6), Color(0xff2C126D)]
              ),
            ),
            child:const Center(
              child: Text(
            "Flutter",
            style: TextStyle(
              decoration: TextDecoration.none,
              color: Color(0xffFDFEFF),
            ),
            ),
            ),   
          ),
        ],
      ),
    ),
  ));
}
