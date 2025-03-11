import 'package:flutter/material.dart';
import 'package:flutterproj/views/widget_tree.dart';
import 'package:lottie/lottie.dart';

String confirmedEmail = '123';
String confirmedPw = '456';

class LoginPage extends StatefulWidget {
  const LoginPage({
    super.key,
    required this.title,
  });

  final String title;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController controller = TextEditingController();
  TextEditingController controllerEmail = TextEditingController(text: '123');
  TextEditingController controllerPw = TextEditingController(text: '456');

  @override
  void dispose() {
    controller.dispose();
    controllerEmail.dispose();
    controllerPw.dispose();
    super.dispose();
  }

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
                Lottie.asset('assets/lotties/home.json', height: 400.0),
                SizedBox(
                  height: 20.0,
                ),
                TextField(
                  controller: controllerEmail,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.5),
                    ),
                  ),
                  onEditingComplete: () {
                    setState(() {});
                  },
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextField(
                  controller: controllerPw,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.5),
                    ),
                  ),
                  onEditingComplete: () {
                    setState(() {});
                  },
                ),
                SizedBox(
                  height: 10.0,
                ),
                FilledButton(
                  onPressed: () {
                    onLoginPress();
                  },
                  child: Text(widget.title),
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

  void onLoginPress() {
    if (confirmedEmail == controllerEmail.text &&
        confirmedPw == controllerPw.text) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) {
            return WidgetTree();
          },
        ),
        (route) => false,
      );
    }
  }
}
