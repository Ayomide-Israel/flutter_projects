import 'package:flutter/material.dart';
import 'package:second_app/dice_roller.dart';

class GradientContainer extends StatelessWidget {
  const GradientContainer(this.gradientColor, {super.key});

  final List<Color> gradientColor;

  @override
  Widget build(context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: gradientColor,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight),
      ),
      child: Center(child: DiceRoller()),
    );
  }
}
