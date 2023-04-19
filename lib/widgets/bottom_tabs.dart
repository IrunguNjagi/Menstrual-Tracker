import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:period_tracker/screens/calendar_picker.dart';
import 'package:period_tracker/screens/display_data.dart';
import 'package:period_tracker/screens/entry.dart';
import 'package:period_tracker/screens/login_page.dart';

class BottomTabs extends StatefulWidget {

  final int selectedTab;
  final Function(int) tabPressed;

  BottomTabs({this.selectedTab, this.tabPressed});

  @override
  _BottomTabsState createState() => _BottomTabsState();
}

class _BottomTabsState extends State<BottomTabs> {
  int _selectedTab = 0;

  @override
  void initState() {
    super.initState();
  }

  void signOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
          (route) => false,
    );
  }



  @override
  Widget build(BuildContext context) {
     _selectedTab = widget.selectedTab ?? 0;
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12.0),
            topRight: Radius.circular(12.0),
          ),
          boxShadow: [
            BoxShadow(

              color: Colors.black.withOpacity(0.1),
              spreadRadius: 1.0,
              blurRadius: 30.0,
            )
          ]
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          BottomTabBtn(

            imagePath: "assets/images/home.png",
            selected: _selectedTab == 0 ? true : false,
            onPressed: () {
              widget.tabPressed(0);
            },
          ),
          BottomTabBtn(
            imagePath: "assets/images/edit.png",
            selected: _selectedTab == 1 ? true : false,
            onPressed: () {
              widget.tabPressed(1);
            },
          ),
          BottomTabBtn(
            imagePath: "assets/images/business-report.png",
            selected: _selectedTab == 2 ? true : false,
            onPressed: () {
              widget.tabPressed(2);
            },
          ),
         BottomTabBtn(
            imagePath: "assets/images/logout2.png",
            selected: _selectedTab == 3 ? true : false,
            onPressed: () {
              signOut();
            },
          ),
        ],
      ),
    );
  }
}

class BottomTabBtn extends StatelessWidget {
  final String imagePath;
  final bool selected;
  final Function onPressed;

  BottomTabBtn({this.imagePath, this.selected, this.onPressed});


  @override
  Widget build(BuildContext context) {
    bool _selected = selected ?? false;


    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 16.0,
        ),
        decoration: BoxDecoration(
            border: Border(
                top: BorderSide(
                  color: _selected ? Theme
                      .of(context)
                      .accentColor : Colors.transparent,
                  width: 2.0,
                )
            )
        ),
        child: Image(
          image: AssetImage(
              imagePath ?? "assets/images/home.png"
          ),
          color: _selected ? Theme
              .of(context)
              .accentColor : Colors.black,
          width: 25.0,
          height: 25.0,
        ),
      ),
    );
  }
}