import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class About extends StatefulWidget {
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  Widget _linkText(String text, String url) {
    return new Column(
      children: <Widget>[
        new GestureDetector(
          onTap: () {
            launch(url);
          },
          child: new Text(text,
              style: new TextStyle(
                color: Colors.blue,
                fontSize: 16.0,
                decoration: TextDecoration.underline,
              )),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(193, 164, 153, 1),
        title: Text('关于'),
      ),
      body: Center(
        child: _linkText("关于作者", "https://github.com/chenzulu123"),
      ),
    );
  }
}
