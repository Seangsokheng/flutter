import 'dart:math';

import 'package:flutter/material.dart';

const String diceImage2 = 'assets/myImage/dice-2.png';
const String diceImage4 = 'assets/myImage/dice-4.png';
const String diceImage3 = 'assets/myImage/dice-3.png';
const String diceImage1 = 'assets/myImage/dice-1.png';
const String diceImage5 = 'assets/myImage/dice-5.png';
const String diceImage6 = 'assets/myImage/dice-6.png';
String activeDiceImage = diceImage2;

class DiceRoller extends StatefulWidget {
  const DiceRoller({super.key});

  @override
  State<DiceRoller> createState() => _DiceRollerState();
}

class _DiceRollerState extends State<DiceRoller> {
  void rollDice() {
    var random = Random();
    int intValue = random.nextInt(6) + 1;
    switch (intValue) {
      case 1:
        activeDiceImage = diceImage1;
        break;
      case 2:
        activeDiceImage = diceImage2;
        break;
      case 3:
        activeDiceImage = diceImage3;
        break;
      case 4:
        activeDiceImage = diceImage4;
        break;
      case 5:
        activeDiceImage = diceImage5;
        break;
      case 6:
        activeDiceImage = diceImage6;
        break;
    }
    setState(() {
      activeDiceImage;
    });
  }

  @override
  Widget build(context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          activeDiceImage,
          width: 200,
        ),
        const SizedBox(height: 20),
        TextButton(
          onPressed: rollDice,
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            textStyle: const TextStyle(
              fontSize: 28,
            ),
          ),
          child: const Text('Roll Dice'),
        )
      ],
    );
  }
}

void main() => runApp(const MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.deepPurple,
        body: Center(child: DiceRoller()),
      ),
    ));
