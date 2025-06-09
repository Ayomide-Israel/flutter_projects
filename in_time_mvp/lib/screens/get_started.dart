import 'package:flutter/material.dart';
import 'package:in_time_mvp/screens/create_account.dart';
import 'package:in_time_mvp/screens/login_page.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({super.key});

  @override
  Widget build(context) {
    final color1 = Color(0xFF7BA163);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset('assets/images/delivery_agent.png'),

              SizedBox(height: 60),
              Text(
                'Get delivery InTime',

                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w200,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreateAccountPage(),
                    ),
                  );
                },
                icon: Icon(Icons.arrow_right_alt),
                style: OutlinedButton.styleFrom(
                  minimumSize: Size(double.infinity, 40.0),
                  backgroundColor: color1,
                  foregroundColor: Colors.white,
                ),
                label: Text('Get Started'),
              ),
              SizedBox(height: 10),
              OutlinedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                icon: Icon(Icons.arrow_right_alt),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.teal[400],
                ),
                label: Text('Log In'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
