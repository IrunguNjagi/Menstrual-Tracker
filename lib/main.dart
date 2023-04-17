import 'package:flutter/material.dart';
import 'package:period_tracker/screens/calendar_picker.dart';
import 'package:period_tracker/screens/demo_screen.dart';
import 'package:period_tracker/screens/home_page.dart';

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
      home: DemoScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
