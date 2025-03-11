import 'package:flutter/material.dart';
import 'package:flutterproj/views/widget/hero_widget.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            HeroWidget(
              title: 'Your Cart',
            ),
          ],
        ),
      ),
    );
  }
}
