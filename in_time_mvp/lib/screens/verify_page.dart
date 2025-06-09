import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerifyPage extends StatefulWidget {
  const VerifyPage({super.key});

  @override
  State<VerifyPage> createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {
  String currentText = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 75),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: FilledButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: FilledButton.styleFrom(
                    shape: const CircleBorder(),
                    backgroundColor: Colors.black,
                    padding: EdgeInsets.zero, // Remove padding
                  ),
                  child: const Icon(Icons.keyboard_arrow_left_sharp, size: 50),
                ),
              ),
              const SizedBox(height: 50),
              const Text(
                'Almost there',
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 20),
              const Text(
                'Please enter the six digit code sent to your email marktimisin@gmail.com for verification.',
              ),
              const SizedBox(height: 40),

              // OTP input field
              PinCodeTextField(
                appContext: context,
                length: 6,
                obscureText: false,
                animationType: AnimationType.fade,
                cursorColor: Colors.black,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(6),
                  fieldHeight: 50,
                  fieldWidth: 40,
                  activeColor: Colors.transparent,
                  selectedColor: Colors.grey,
                  inactiveColor: const Color.fromRGBO(112, 160, 255, 1),
                  activeFillColor: Color.fromRGBO(196, 196, 196, 0.2),
                  selectedFillColor: Colors.transparent,
                  inactiveFillColor: Colors.white60,
                ),
                animationDuration: const Duration(milliseconds: 300),
                enableActiveFill: true,
                onChanged: (value) {
                  setState(() {
                    currentText = value;
                  });
                },
              ),

              const SizedBox(height: 30),

              // Verify button
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Code entered: $currentText')),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                  ),
                  child: const Text('Verify'),
                ),
              ),

              const SizedBox(height: 20),

              // Resend text
              const Center(
                child: Text.rich(
                  TextSpan(
                    text: "Didn't receive any code? ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                    children: [
                      TextSpan(
                        text: "Resend Again",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 10),
              const Center(child: Text("Request a new code in 00:30s")),
            ],
          ),
        ),
      ),
    );
  }
}
