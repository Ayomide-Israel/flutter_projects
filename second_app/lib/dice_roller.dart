import 'package:flutter/material.dart';
import 'dart:math';

final randomizer = Random();

class DiceRoller extends StatefulWidget {
  const DiceRoller({super.key});

  @override
  State<DiceRoller> createState() {
    return _DiceRoller();
  }
}

class _DiceRoller extends State<DiceRoller> {
  var currentDiceRoll = 2;

  void rollDice() {
    setState(
      () {
        currentDiceRoll = randomizer.nextInt(6) + 1;
      },
    );
  }

  @override
  Widget build(context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          'assets/images/dice-images/dice-$currentDiceRoll.png',
          width: 200,
        ),
        FilledButton(
            onPressed: () {
              rollDice();
            },
            child: Text('Roll Dice!'))
      ],
    );
  }
}
