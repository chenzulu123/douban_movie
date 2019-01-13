import 'package:flutter/material.dart';
// import 'splash_screen.dart';
import './screen/splash_screen.dart';
void main() => runApp(MyApp());
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '豆瓣电影',
      theme: ThemeData(
        primarySwatch:Colors.blue,
      ),
      home:SplashScreen()
    );
  }
}