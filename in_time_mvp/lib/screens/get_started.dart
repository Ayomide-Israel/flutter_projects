import 'package:flutter/material.dart';
import 'package:in_time_mvp/screens/create_account.dart';
import 'package:in_time_mvp/screens/login_page.dart';

class GetStartedScreen extends StatelessWidget {
  // Removed duplicate constructor

  static const Color _primaryColor = Color(0xFF7BA163);
  static const TextStyle _titleStyle = TextStyle(
    fontSize: 25,
    fontWeight: FontWeight.w200,
    color: Colors.white,
  );

  void _navigateToCreateAccount(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => CreateAccountPage(
              onLoginPressed: () => _navigateToLoginPage(context),
            ),
      ),
    );
  }

  void _navigateToLoginPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => LoginPage(
              onSignUpPressed: () => _navigateToCreateAccount(context),
            ),
      ),
    );
  }

  const GetStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Use const if the image is static and not dependent on runtime
              Image.asset('assets/images/delivery_agent.png'),
              const SizedBox(height: 60),
              const Text('Get delivery InTime', style: _titleStyle),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                  _navigateToCreateAccount(context);
                },
                icon: const Icon(Icons.arrow_right_alt),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 40.0),
                  backgroundColor: _primaryColor,
                  foregroundColor: Colors.white,
                ),
                label: const Text('Get Started'),
              ),
              const SizedBox(height: 10),
              OutlinedButton.icon(
                onPressed: () {
                  _navigateToLoginPage(context);
                },
                icon: const Icon(Icons.arrow_right_alt),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.teal[400],
                ),
                label: const Text('Log In'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
