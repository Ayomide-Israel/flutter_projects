import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  TextEditingController controller = TextEditingController();
  bool? isChecked = false;
  bool isSwitched = false;
  double sliderValue = 0.0;
  String? menuItem = "e1";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  DropdownButton(
                    value: menuItem,
                    items: [
                      DropdownMenuItem(
                        value: "e1",
                        child: Text("Element 1"),
                      ),
                      DropdownMenuItem(
                        value: "e2",
                        child: Text("Element 2"),
                      ),
                      DropdownMenuItem(
                        value: "e3",
                        child: Text("Element 3"),
                      ),
                    ],
                    onChanged: (String? value) {
                      setState(() {
                        menuItem = value;
                      });
                    },
                  ),
                ],
              ),
              TextField(
                controller: controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
                onEditingComplete: () {
                  setState(() {});
                },
              ),
              Text(controller.text),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Welcome!"),
                          behavior: SnackBarBehavior.floating,
                          duration: Duration(seconds: 10),
                        ),
                      );
                    },
                    child: Text("Open Snackbar"),
                  ),
                  Divider(
                    color: Colors.deepPurpleAccent,
                    thickness: 2.0,
                    endIndent: 200,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("Alert Title"),
                            content: Text("Alert Content"),
                            actions: [
                              FilledButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text("Close"))
                            ],
                          );
                        },
                      );
                    },
                    child: Text("Open Alert"),
                  ),
                  Checkbox(
                    tristate: true,
                    value: isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked = value;
                      });
                    },
                  ),
                  CheckboxListTile(
                    tristate: true,
                    title: Text("Click!"),
                    value: isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked = value;
                      });
                    },
                  ),
                  Switch(
                    value: isSwitched,
                    onChanged: (value) {
                      setState(() {
                        isSwitched = value;
                      });
                    },
                  ),
                  SwitchListTile(
                    title: Text("Show Amount"),
                    value: isSwitched,
                    onChanged: (value) {
                      setState(() {
                        isChecked = value;
                      });
                    },
                  ),
                  Slider.adaptive(
                    max: 10.0,
                    divisions: 10,
                    value: sliderValue,
                    onChanged: (double value) {
                      setState(() {
                        sliderValue = value;
                      });
                      print(sliderValue);
                    },
                  ),
                  InkWell(
                    splashColor: const Color.fromARGB(255, 23, 53, 50),
                    onTap: () {
                      print("Image Selected");
                    },
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      color: Colors.white12,
                    ),
                  ),
                  FilledButton(
                    onPressed: () {},
                    child: Text("Click Me!"),
                  ),
                  TextButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 16, 66, 61)),
                    child: Text("Click me!"),
                  ),
                  Image.asset('assets/images/bg.jpeg'),
                  Image.asset('assets/images/bg.jpeg'),
                  Image.asset('assets/images/bg.jpeg'),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
