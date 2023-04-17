import 'package:flutter/material.dart';
import 'package:period_tracker/screens/entry.dart';
import 'package:table_calendar/table_calendar.dart';

class DemoScreen extends StatefulWidget {

  @override
  _DemoScreenState createState() => _DemoScreenState();
}

class _DemoScreenState extends State<DemoScreen> {

  CalendarController _calendarController;
  DateTime _lastPeriodDate;
  int _cycleLength = 28;
  int _ovulationlength = 14;

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
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

  int _calculateNextPeriodDay() {
    if (_lastPeriodDate == null) {
      return null;
    }
    return _lastPeriodDate
        .add(Duration(days: _cycleLength))
        .millisecondsSinceEpoch;
  }

  int _calculateNextOvulationDate() {
    if ( _lastPeriodDate == null ) {
      return null;
    }
    return _lastPeriodDate
        .add(Duration(days: _ovulationlength))
        .millisecondsSinceEpoch;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFBE2F5).withOpacity(0.99),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(left: 20, right: 20, top: 50),
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
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left:5,
                right:20,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 300,
                        width: 300,
                        decoration: BoxDecoration(
                            color: Colors.pinkAccent,
                            borderRadius: BorderRadius.circular(150)
                        ),
                      ),
                      Positioned.fill(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Next period',
                                style: TextStyle(
                                  color: Colors.black.withOpacity(0.54),
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                ' ${_calculateNextPeriodDay() != null
                                    ? DateTime.fromMillisecondsSinceEpoch(_calculateNextPeriodDay())
                                    .difference(DateTime.now())
                                    .inDays : 'N/A'} days remaining',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w300,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 15,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.calendar_today,  // Replace with your desired icon
                          color: Colors.grey[800],
                        ),
                        Text(
                          'Last period:',
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
                    padding: const EdgeInsets.only(
                      left: 15,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.loop,  // Replace with your desired icon
                          color: Colors.grey[800],
                        ),
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
                  SizedBox(
                    height: 20.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 15.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.watch,  // Replace with your desired icon
                          color: Colors.grey[800],
                        ),
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
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 30),
            Container(
              padding: EdgeInsets.only(
                left: 13,
                right: 13,
                bottom: 20,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                    top: 10,
              ),
                    child: Text(
                      'Drink some water today',
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.54),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,

                      ),
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
                          Icons.local_florist,
                          color: Colors.white,
                          size: 45,
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
                                color: Colors.black,
                                fontSize: 18,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Track your mood, symptoms and more',
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 18,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w400,
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
                          borderRadius: BorderRadius.circular(25),
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