import 'package:flutter/material.dart';
import 'package:flutterproj/data/constants.dart';
import 'package:flutterproj/data/notifiers.dart';
import 'package:flutterproj/views/pages/home_page.dart';
import 'package:flutterproj/views/pages/profile_page.dart';
import 'package:flutterproj/views/pages/setting_page.dart';
import 'package:flutterproj/views/pages/welcome_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'widget/navbar_widget.dart';

List<Widget> pages = [
  HomePage(),
  ProfilePage(),
];

class WidgetTree extends StatelessWidget {
  const WidgetTree({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: (Text(
          "IN TIME",
        )),
        actions: [
          IconButton(
            onPressed: () async {
              isDarkModeNotifier.value = !isDarkModeNotifier.value;
              final SharedPreferences prefs =
                  await SharedPreferences.getInstance();
              await prefs.setBool(
                  KConstants.themeModeKey, isDarkModeNotifier.value);
            },
            icon: ValueListenableBuilder(
              valueListenable: isDarkModeNotifier,
              builder: (context, isDarkMode, child) {
                return Icon(
                  isDarkMode ? Icons.light_mode : Icons.dark_mode,
                );
              },
            ),
          ),
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SettingPage();
                    },
                  ),
                );
              },
              icon: Icon(Icons.settings))
        ],
      ),
      drawer: Drawer(
        child: ElevatedButton(
          onPressed: () {
            selectedPageNotifier.value = 0;
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return WelcomePage(
                    title: 'Login',
                  );
                },
              ),
            );
          },
          child: Text("Logout"),
        ),
      ),
      body: ValueListenableBuilder(
        valueListenable: selectedPageNotifier,
        builder: (context, selectedPage, child) {
          return pages.elementAt(selectedPage);
        },
      ),
      bottomNavigationBar: NavbarWidget(),
    );
  }
}
