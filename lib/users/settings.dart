import 'package:flutter/material.dart';
class Settings extends StatefulWidget {
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('系统设置'),
      ),
      body: Center(
        child: Text(
          '系统设置'
        ),
      ),
    );
  }
}