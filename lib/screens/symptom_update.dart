import 'package:flutter/material.dart';
import 'package:period_tracker/screens/entry.dart';
import 'package:period_tracker/screens/info_details.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class CustomInformationPage extends StatefulWidget {
  @override
  _CustomInformationPageState createState() => _CustomInformationPageState();
}

class _CustomInformationPageState extends State<CustomInformationPage> {
  final _formKey = GlobalKey<FormState>();
  final _infoController = TextEditingController();

  Database _database;

  @override
  void initState() {
    super.initState();
    _initDatabase();
  }

  Future<void> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'custom_info.db');
    _database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          await db.execute(
            'CREATE TABLE CustomInformation(id INTEGER PRIMARY KEY, info TEXT)',
          );
        });
  }

  Future<void> _insertInfo(String info) async {
    await _database.insert(
      'CustomInformation',
      {'info': info},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> _updateInfo(int id, String info) async {
    await _database.update(
      'CustomInformation',
      {'id': id, 'info': info},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> _deleteInfo(int id) async {
    await _database.delete(
      'CustomInformation',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Map<String, dynamic>>> _getInfos() async {
    return await _database.query('CustomInformation');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Custom Information'),
      ),
      body: Column(
          children: [
      Expanded(
      child: FutureBuilder<List<Map<String, dynamic>>>(
          future: _getInfos(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        final infos = snapshot.data;

        return ListView.builder(
          itemCount: infos.length,
          itemBuilder: (context, index) {
            final info = infos[index]['info'];
            final id = infos[index]['id'];

            return ListTile(
              title: Text(info),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  _deleteInfo(id);
                  setState(() {});
                },
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      DataEntry(),
                ));
              },
            );
          },
        );
      },
    ),
    ),
    Divider(),
    Padding(
    padding: const EdgeInsets.all(8.0),
    child: Form(
    key: _formKey,
    child: TextFormField(
    controller: _infoController,
    decoration: InputDecoration(hintText: 'Custom information'),
    validator: (value) {
    if (value.isEmpty) {
    return 'Please enter some information';
    }
    return null;
    },
    ),
    ),
    ),
    RaisedButton(
    child: Text('Add'),
    onPressed: () {
    if (_formKey.currentState.validate()) {
    _insertInfo(
        _infoController.text);
        _infoController.clear();
    setState(() {});
    }
    },
    ),
          ],
      ),
    );
  }
}