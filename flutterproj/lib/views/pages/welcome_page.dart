import 'package:flutter/material.dart';
import 'package:flutterproj/views/pages/login_page.dart';
import 'package:flutterproj/views/pages/onboarding_widget.dart';
import 'package:lottie/lottie.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key, required, required String title});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset('assets/lotties/wavy2.json', height: 400.0),
                FittedBox(
                  child: Text(
                    'IN TIME',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 50.0,
                      letterSpacing: 50,
                    ),
                  ),
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
                          return OnboardingPage();
                        },
                      ),
                    );
                  },
                  style: FilledButton.styleFrom(
                    minimumSize: Size(double.infinity, 40.0),
                  ),
                  child: Text("Get Started"),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return LoginPage(title: 'Login');
                        },
                      ),
                    );
                  },
                  style: FilledButton.styleFrom(
                    minimumSize: Size(double.infinity, 40.0),
                  ),
                  child: Text("Login"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
