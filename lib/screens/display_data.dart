import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'entry.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';


class DataDisplay extends StatefulWidget {
  @override
  _DataDisplayState createState() => _DataDisplayState();
}

class _DataDisplayState extends State<DataDisplay> {
  List<DataModel> _dataList = [];

  @override
  void initState() {
    super.initState();
    _getDataList();
  }

  Future<void> _getDataList() async {
    final dataList = await DatabaseHelper.instance.getData();
    setState(() {
      _dataList = dataList;
    });
  }

  Future<void> _deleteData(int id) async {
    await DatabaseHelper.instance.deleteData(id);
    setState(() {
      _dataList.removeWhere((data) => data.id == id);
    });
  }

  Future<void> _shareData() async {
    final data = _dataList.map((data) => data.data).join("\n");
    await Share.share(data);
  }
 /*
  Future<void> _downloadAndShareData() async {
    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/data.txt');

    // Write all data to the file
    final dataString = _dataList.map((data) => data.data).join('\n');
    await file.writeAsString(dataString);

    // Share the file
    final bytes = await file.readAsBytes();
    final data = base64Encode(bytes);
    await Share.shareFiles([file.path], text: 'Data file', mimeTypes: ['text/plain'], subject: 'Data', sharePositionOrigin: Rect.zero);

    // Delete the file
    await file.delete();
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pinkAccent,
      /*appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        automaticallyImplyLeading: false,
        title: Text('Data Display'),
      ),*/
      body: Padding(
        padding: const EdgeInsets.only(
          top: 60,
          right: 16.0,
          left: 16.0,
        ),
        child: Column(
          children: [
            Container(
              height: 130,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: Colors.white30,
              ),
            ),

            Expanded(
            child: _dataList.isEmpty
                ? Center(
              child: Text('No data found'),
            )
                : ListView.builder(
              itemCount: _dataList.length,
              itemBuilder: (context, index) {
                final data = _dataList[index];
                return Card(
                  color: Colors.white24.withOpacity(0.7),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Colors.white24,
                    ),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: ListTile(
                    title: Text(data.data),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            _deleteData(data.id);
                          },
                        ),
                         IconButton(
                         icon: Icon(Icons.share),
                          onPressed: _shareData,
                         ),
                      ],
                    ),
                    dense: true,
                  ),
                );
              },
            ),
          ),

            Padding(
              padding: const EdgeInsets.only(
                bottom: 90,
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  color: Colors.white24,
                ),
                child: FlatButton(
                  onPressed: () {
                  _shareData();
                  },
                  child: Text(
                    "SHARE ALL"
                  ),
                ),
              ),
            )
    ],
        ),
      ),
     /* floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_downward),
        onPressed: _downloadAndShareData,
      ),*/
    );
  }
}