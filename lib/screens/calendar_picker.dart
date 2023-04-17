import 'package:flutter/material.dart';
import 'package:period_tracker/screens/entry.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';


class PeriodTrackerApp extends StatefulWidget {
  @override
  _PeriodTrackerAppState createState() => _PeriodTrackerAppState();
}

class _PeriodTrackerAppState extends State<PeriodTrackerApp> {
  CalendarController _calendarController;
  DateTime _lastPeriodDate;
  int _cycleLength = 28;
  int _ovulationlength = 14;


  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
    _loadLastPeriodDate();
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  void _loadLastPeriodDate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String lastPeriodDateStr = prefs.getString('lastPeriodDate');
    if (lastPeriodDateStr != null) {
      setState(() {
        _lastPeriodDate = DateTime.parse(lastPeriodDateStr);
      });
    }
  }
  void _onDaySelected(DateTime day, List<dynamic> events,
      List<dynamic> holidays) {
    setState(() {
      _lastPeriodDate = day;
    });
  }

  void _onCycleLengthChanged(String value) {
    setState(() {
      _cycleLength = int.parse(value);
    });
  }

  int _calculateNextOvulationDate() {
    if ( _lastPeriodDate == null ) {
      return null;
    }
    return _lastPeriodDate
        .add(Duration(days: _ovulationlength))
        .millisecondsSinceEpoch;
  }

  int _calculateNextPeriodDay() {
    if (_lastPeriodDate == null) {
      return null;
    }
    return _lastPeriodDate
        .add(Duration(days: _cycleLength))
        .millisecondsSinceEpoch;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      appBar: AppBar(
        title: Text(
          'Period Tracker',
          style: TextStyle(color: Colors.pink),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(left: 20, right: 20, top: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
              ),
              child: TableCalendar(
                calendarController: _calendarController,
                onDaySelected: _onDaySelected,
                initialCalendarFormat: CalendarFormat.week,
                calendarStyle: CalendarStyle(
                  todayColor: Colors.pink[300],
                  selectedColor: Colors.pink,
                  selectedStyle: TextStyle(color: Colors.white),
                  todayStyle: TextStyle(color: Colors.white),
                ),
                headerStyle: HeaderStyle(
                  centerHeaderTitle: true,
                  formatButtonDecoration: BoxDecoration(
                    color: Colors.pink,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  formatButtonTextStyle: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Last period',
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    _lastPeriodDate?.toString()?.substring(0, 10) ?? 'N/A',
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Cycle length',
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '$_cycleLength days',
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Next period',
                        style: TextStyle(
                          color: Colors.grey[800],
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        _calculateNextPeriodDay() != null
                            ? DateTime.fromMillisecondsSinceEpoch(
                            _calculateNextPeriodDay())
                            .toString()
                            .substring(0, 10)
                            : 'N/A',
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Due Ovulation',
                        style: TextStyle(
                          color: Colors.grey[800],
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                          _calculateNextOvulationDate() != null
                              ? DateTime.fromMillisecondsSinceEpoch(
                              _calculateNextOvulationDate())
                              .toString()
                              .substring(0, 10)
                              : 'N/A',
                              style:   TextStyle(
                        color: Colors.grey[700],
                        fontSize: 18,
                      ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: 30),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Today',
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.pink,
                        ),
                        child: Icon(
                          Icons.local_hospital,
                          color: Colors.white,
                          size: 35,
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Period expected in ${_calculateNextPeriodDay() !=
                                  null ? DateTime
                                  .fromMillisecondsSinceEpoch(
                                  _calculateNextPeriodDay())
                                  .difference(DateTime.now())
                                  .inDays : 'N/A'} days',
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 18,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Track your mood, symptoms and more',
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 20),
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.pink,
                        ),
                        child: IconButton(
                          icon: Icon(Icons.add),
                          color: Colors.white,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => DataEntry()),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
