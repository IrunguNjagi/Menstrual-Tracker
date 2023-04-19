import 'package:flutter/material.dart';
import 'package:period_tracker/custom/custom_button.dart';
import 'package:period_tracker/screens/landing_page.dart';
import 'package:period_tracker/screens/login_page.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.asset(
            'assets/images/woman_flow.png',
            height: 300,
            width: 300,
          ),
          SizedBox(height: 50),
          Text(
            'Welcome to Cycle Tracker',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w500,
              color: Colors.pink[800],
              fontStyle: FontStyle.italic,
            ),
          ),
          SizedBox(height: 20),
          Text(
            'Track your cycle with inbuilt functions and share your symptoms with others on other platforms',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              color: Colors.pink[800],
              fontStyle: FontStyle.italic,
            ),
          ),
          SizedBox(height: 50),
          CustomBtn(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => LandingPage()
              ));
            },
              text: 'Get Started',
            ),
      ],
    ),
    );
  }
}