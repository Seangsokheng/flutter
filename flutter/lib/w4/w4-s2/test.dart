import 'package:flutter/material.dart';

const String diceImage2 = 'assets/myImage/dice-2.png';
const String diceImage4 = 'assets/myImage/dice-4.png';

String activeDiceImage = diceImage2;

class DiceRoller extends StatelessWidget {
  const DiceRoller({super.key});

  void rollDice() {
    activeDiceImage = diceImage4;
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
