import 'package:flutter/material.dart';
import 'package:period_tracker/screens/calendar_picker.dart';
import 'package:period_tracker/screens/Date_Select.dart';
import 'package:period_tracker/screens/home_page.dart';
import 'package:period_tracker/screens/landing_page.dart';
import 'package:period_tracker/screens/welcome_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        accentColor: Colors.pink,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: WelcomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
