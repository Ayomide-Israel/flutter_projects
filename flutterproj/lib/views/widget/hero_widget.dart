import 'package:flutter/material.dart';

class HeroWidget extends StatelessWidget {
  const HeroWidget({
    super.key,
    required this.title,
    this.nextPage,
  });

  final String title;
  final Widget? nextPage;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: nextPage != null
          ? () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return nextPage!;
                  },
                ),
              );
            }
          : null,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Hero(
            tag: "hero1",
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30.0),
              child: Image.asset('assets/images/bg2.jpg'),
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 35.0,
              fontWeight: FontWeight.bold,
              letterSpacing: 30.0,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
