import 'package:flutter/material.dart';

class SymptomPage extends StatefulWidget {
  @override
  _SymptomPageState createState() => _SymptomPageState();
}

class _SymptomPageState extends State<SymptomPage> {
  List<String> _selectedSymptoms = [];

  final List<String> _allSymptoms = [
    'Fatigue',
    'Cramps',
    'Bloating',
    'Headache',
    'Nausea',
    'Back Pain',
    'Mood Swings',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Symptoms'),
      ),
      body: ListView.builder(
        itemCount: _allSymptoms.length,
        itemBuilder: (context, index) {
          return CheckboxListTile(
            title: Text(_allSymptoms[index]),
            value: _selectedSymptoms.contains(_allSymptoms[index]),
            onChanged: (checked) {
              setState(() {
                if (checked) {
                  _selectedSymptoms.add(_allSymptoms[index]);
                } else {
                  _selectedSymptoms.remove(_allSymptoms[index]);
                }
              });
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context, _selectedSymptoms);
        },
        child: Icon(Icons.save),
      ),
    );
  }
}