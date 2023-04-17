import 'package:flutter/material.dart';

class CustomInfoDetailsPage extends StatelessWidget {
  final String info;

  CustomInfoDetailsPage({this.info});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Custom Information Details'),
      ),
      body: Center(
        child: Text(info),
      ),
    );
  }
}