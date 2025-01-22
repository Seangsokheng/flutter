import 'package:flutter/material.dart';
import 'pages/home_page.dart';

void main() {
  runApp(const SportsEventApp());
}

class SportsEventApp extends StatelessWidget {
  const SportsEventApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sports Event App',
      home: HomePage(),
    );
  }
}
