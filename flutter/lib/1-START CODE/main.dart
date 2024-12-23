import 'package:flutter/material.dart';
import 'package:week3/1-START%20CODE/widgets/courses_view.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
 
      home: CoursesView(), // TODO To change
    );
  }
}
