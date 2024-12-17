import 'package:flutter/material.dart';
import 'package:week3/w6/w6-s1/EXERCISE-3/screen/temperature.dart';
import 'package:week3/w6/w6-s1/EXERCISE-3/screen/welcome.dart';

class TemperatureApp extends StatefulWidget {
  const TemperatureApp({super.key});

  @override
  State<TemperatureApp> createState() {
    return _TemperatureAppState();
  }
}

class _TemperatureAppState extends State<TemperatureApp> {
  bool showNextScreen = false;

  void switchScreen() {
    setState(() {
      showNextScreen = !showNextScreen;
    });
  }

  @override
  Widget build(context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xff16C062),
                Color(0xff00BCDC),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          
          child: showNextScreen ? Temperature(switchScreen : switchScreen ) : Welcome(switchScreen: switchScreen,),
        ),
      ),
    );
  }
}

void main() {
  runApp(const TemperatureApp());
}
