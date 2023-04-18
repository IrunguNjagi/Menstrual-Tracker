import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:period_tracker/custom/custom_button.dart';
import 'package:period_tracker/custom/custom_input.dart';
import 'package:period_tracker/screens/home_page.dart';
import 'package:period_tracker/screens/register_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Future<void> _alertDialogBuilder(String error) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Container(
              child: Text(error),
            ),
            actions: [
              FlatButton(
                child: Text('Close Dialog'),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }

  Future<String> _loginAccount() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _loginEmail, password: _loginPassword);
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return 'The account already exists for the email';
      } else if (e.code == 'weak-password') {
        return 'The password is too weak';
      }
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

  void _submitForm() async {
    setState(() {
      _LoginFormLoading = true;
    });
    String _LoginAccountFeedback = await _loginAccount();
    if (_LoginAccountFeedback != null) {
      _alertDialogBuilder(_LoginAccountFeedback);

      setState(() {
        _LoginFormLoading = false;
      });
    } else {
      //string was null,user logged in
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
    }
  }

  String _loginEmail = "";
  String _loginPassword = "";

  bool _LoginFormLoading = false;

  FocusNode _passwordFocusNode;

  @override
  void initState() {
    // TODO: implement initState
    _passwordFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffFBE2F5).withOpacity(0.99),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
            Container(
            padding: EdgeInsets.only(
            top: 24,
            ),
            child: Text(
              'Welcome user, \n Login to your account',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.w600,
                color: Colors.black),
            ),
          ),
        Column(
          children: [
            CustomInput(
              hintText: 'Email..',
              onChanged: (value) {
                _loginEmail = value;
              },
              onSubmitted: (value) {
                _passwordFocusNode.requestFocus();
              },
              textInputAction: TextInputAction.next,
            ),
            CustomInput(
              hintText: 'Password..',
              onChanged: (value) {
                _loginPassword = value;
              },
              onSubmitted: (value) {
                _submitForm();
              },
              focusNode: _passwordFocusNode,
              hidePassword: true,
            ),
            CustomBtn(
              text: 'Login',
              onPressed: () {
                _submitForm();
              },
              isLoading: _LoginFormLoading,
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(
            bottom: 16.0,
          ),
          child: CustomBtn(
            text: 'Create New Account',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RegisterPage()),
              );
            },
            outlineBtn: true,
          ),
        ),
        ],
      ),
    )),
    )
    );
  }
}

