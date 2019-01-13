import 'package:flutter/material.dart';
// 电影搜索页面
class MovieSearch extends StatefulWidget {
  _MovieSearchState createState() => _MovieSearchState();
}
class _MovieSearchState extends State<MovieSearch> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
         title: Text('电影搜索'),
       ),
       body: Center(
         child: Text('电影搜索页'),
       ),
    );
  }
}