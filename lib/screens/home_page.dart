import 'package:flutter/material.dart';
import 'package:period_tracker/screens/Date_Select.dart';
import 'package:period_tracker/screens/calendar_picker.dart';
import 'package:period_tracker/screens/display_data.dart';
import 'package:period_tracker/screens/entry.dart';
import 'package:period_tracker/widgets/bottom_tabs.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  PageController _tabsPageController;
  int _selectedTab = 0;

  @override
  void initState() {

    _tabsPageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _tabsPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: PageView(
                controller: _tabsPageController,
                onPageChanged: (num){
                  setState(() {
                    _selectedTab = num;
                  });
                },
                children: [
                  DateSelect(),
                  DataEntry(),
                  DataDisplay(),
                ],
              ),
            ),
            BottomTabs(
              selectedTab: _selectedTab,
              tabPressed: (num){
                _tabsPageController.animateToPage(num,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeOutCubic);
              },

            ),
          ],
        ));
  }
}

