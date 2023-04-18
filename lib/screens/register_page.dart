
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:period_tracker/custom/custom_button.dart';
import 'package:period_tracker/custom/custom_input.dart';



class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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

  Future<String> _createAccount() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _registeredEmail, password: _registeredPassword);
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

  //submit method
  void _submitForm() async {
    setState(() {
      _LoginFormLoading = true;
    });
    String _createAccountFeedback = await _createAccount();
    if (_createAccountFeedback != null) {
      _alertDialogBuilder(_createAccountFeedback);

      setState(() {
        _LoginFormLoading = false;
      });
    } else {
      //string was null,user logged in
      Navigator.pop(context);
    }
  }

  //Form Input Values

  String _registeredEmail = "";
  String _registeredPassword = "";

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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.only(
                  top: 24,
                ),
                child: Text(
                  'Create a new account',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
              Column(
                children: [
                  CustomInput(
                    hintText: 'Email..',
                    onChanged: (value) {
                      _registeredEmail = value;
                    },
                    onSubmitted: (value) {
                      _passwordFocusNode.requestFocus();
                    },
                    textInputAction: TextInputAction.next,
                  ),
                  CustomInput(
                    hintText: 'Password..',
                    onChanged: (value) {
                      _registeredPassword = value;
                    },
                    onSubmitted: (value) {
                      _submitForm();
                    },
                    focusNode: _passwordFocusNode,
                    hidePassword: true,
                  ),
                  CustomBtn(
                    text: 'Create New Account',
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
                  text: 'Back to Login Page',
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  outlineBtn: true,
                ),
              ),
            ],
          )),
    ));
  }
}
