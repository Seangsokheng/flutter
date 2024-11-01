import 'package:flutter/material.dart';

enum Product {
  dart,
  firebase,
  flutter,
}

extension ProductDetails on Product {
  String get title {
    switch (this) {
      case Product.dart:
        return "Dart";
      case Product.firebase:
        return "Firebase";
      case Product.flutter:
        return "Flutter";
    }
  }

  String get description {
    switch (this) {
      case Product.dart:
        return "The best object language";
      case Product.firebase:
        return "The best cloud database";
      case Product.flutter:
        return "The best mobile widget libery";
    }
  }

  String get image {
    switch (this) {
      case Product.dart:
        return "assets/w4-s1-ex/Dart.jpg";
      case Product.firebase:
        return "assets/w4-s1-ex/Firebase.jpg";
      case Product.flutter:
        return "assets/w4-s1-ex/Flutter.jpg";
    }
  }
}

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        body: Container(
          color: Colors.blue,
          child: Padding(
            padding:const EdgeInsets.all(40),
            child: Column(
              children: [
                Card(title: Product.dart.title, description: Product.dart.description, image: Product.dart.image),
                const SizedBox(height: 20,),
                Card(title: Product.flutter.title, description: Product.flutter.description, image: Product.flutter.image),
                const SizedBox(height: 20,),
                Card(title: Product.firebase.title, description: Product.firebase.description, image: Product.firebase.image),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

class Card extends StatelessWidget {
  final String title;
  final String description;
  final String image;
  const Card({required this.title, required this.description, required this.image, super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 200,
        width: 500,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                height: 80,
                width: 140,
                image,
              ),
              // const SizedBox(height: 10,),
              Text(
                title,
                style:const TextStyle(
                  fontSize: 30,
                
                ),
              ),
              // const SizedBox(height: 10,),
              Text(description),
            ],
          ),
        ),
      ),
    );
  }
}
