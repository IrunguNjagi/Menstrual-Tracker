import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:period_tracker/screens/data_model.dart';
import 'package:period_tracker/screens/database_helper.dart';
import 'package:share/share.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'display_data.dart';



class DataEntry extends StatefulWidget {
  @override
  _DataEntryState createState() => _DataEntryState();
}

class _DataEntryState extends State<DataEntry> {
  final TextEditingController _textEditingController = TextEditingController();

  Future<void> _saveData(String data) async {
    final newData = DataModel(data: data);
    await DatabaseHelper.instance.insertData(newData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pinkAccent.withOpacity(0.94),
      /* appBar: AppBar(
        title: Text('Data Entry'),
      ),*/
      body: Padding(
        padding: const EdgeInsets.only(
          top: 60,
          left: 16,
          right: 16,
        ),
        child: Column(
          children: [
            Container(
              height: 130,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: Colors.white30,
                image: DecorationImage(
                  image: AssetImage('assets/images/woman_flow.png'),
                  fit: BoxFit.fitWidth
                )
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Text(
                "Enter Symptoms below",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.italic,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 16.0,
                right: 16.0,
              ),
              child: TextField(
                controller: _textEditingController,
                decoration: InputDecoration(
                  hintText: 'How are you feeling today?',
                    hintStyle: TextStyle(
                      fontSize: 17.0,
                      color: Colors.black,
                      fontStyle: FontStyle.italic,
                    ),
                  filled: true,
                  fillColor: Colors.white30,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide(
                      width: 3,
                      color: Colors.white30,
                    )
                  )
                ),
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(90.0),
              ),
              child: FlatButton(
                onPressed: () {
                  _saveData(_textEditingController.text.trim());
                  _textEditingController.clear();
                },
                child: Text('ADD SYMPTOM'),
              ),
            ),
            SizedBox(
              height: 100.0,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                color: Colors.white24,
              ),
              child: FlatButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DataDisplay()),
                  );
                },
                child: Text("SHOW SAVED SYMPTOMS"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
