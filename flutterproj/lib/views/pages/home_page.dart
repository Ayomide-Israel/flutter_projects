import 'package:flutter/material.dart';
import 'package:flutterproj/data/constants.dart';
import 'package:flutterproj/views/pages/cart_page.dart';
import 'package:flutterproj/views/widget/container_widget.dart';
import 'package:flutterproj/views/widget/hero_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> list = [
      KValue.basicLayout,
      KValue.keyConcepts,
      KValue.cleanUI,
      KValue.fixBugs,
      KValue.flowbox,
    ];

    List<String> descrip = [
      KDescrip.basicLayout,
      KDescrip.keyConcepts,
      KDescrip.cleanUI,
      KDescrip.fixBugs,
      KDescrip.flowbox,
    ];
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            SizedBox(height: 10),
            HeroWidget(
              title: 'Home Page',
              nextPage: CartPage(),
            ),
            SizedBox(height: 10),
            ...List.generate(
              list.length,
              (index) {
                return ContainerWidget(
                  title: list.elementAt(index),
                  description: descrip.elementAt(index),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
