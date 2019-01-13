import 'package:flutter/material.dart';
class Publish extends StatefulWidget {
  _PublishState createState() => _PublishState();
}

class _PublishState extends State<Publish> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('我要发布'),
      ),
      body: Center(
        child: Text('我要发布'),
      ),
    );
  }
}