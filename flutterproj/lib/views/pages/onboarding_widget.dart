import 'package:flutter/material.dart';
import 'package:flutterproj/data/constants.dart';
import 'package:flutterproj/views/pages/login_page.dart';
import 'package:lottie/lottie.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({
    super.key,
    required,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Login"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset('assets/lotties/welcome1.json', height: 400.0),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  'Logistics just got better!',
                  style: KTextStyle.titlePurpleText,
                  textAlign: TextAlign.justify,
                ),
                SizedBox(
                  height: 20.0,
                ),
                FilledButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return LoginPage(title: 'Register');
                        },
                      ),
                    );
                  },
                  child: Text('Next'),
                ),
                SizedBox(
                  height: 100.0,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
