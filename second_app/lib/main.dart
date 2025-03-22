import 'package:flutter/material.dart';
import 'package:second_app/gradient_container.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 21, 4, 51),
        body: GradientContainer(
          [
            const Color.fromARGB(255, 42, 22, 78),
            const Color.fromARGB(255, 21, 8, 45),
          ],
        ),
      ),
    ),
  );
}
