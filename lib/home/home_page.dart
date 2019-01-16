import 'package:flutter/material.dart';
import '../movie/list.dart';
import '../users/about.dart';
import '../users/publish.dart';
import '../users/settings.dart';
import '../movie/movie_search.dart';
import 'dart:ui';
import 'package:url_launcher/url_launcher.dart';
class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Index(title: '豆瓣电影',),
    );
  }
}

class Index extends StatefulWidget {
  Index({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _IndexState createState() => _IndexState();
}

class _IndexState extends State<Index> {

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

  //默认索引
  int positionIndex = 0;
  //底部导航栏
  var mainTitles = ['正在热映', '即将上映','top250'];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            // leading: Icon(Icons.save),
            title: Text(widget.title,style: TextStyle(),textAlign: TextAlign.right,),
            centerTitle: true,
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.search),
                iconSize: 30,
                color: Colors.white,
                highlightColor: Colors.redAccent,
                padding: EdgeInsets.only(right: 25,top: 2),
                onPressed: (){
                  Navigator.push(context,
                        MaterialPageRoute(builder: (BuildContext context) {
                      return MovieSearch();
                    }));
                },
                
              )
            ],
          ),
          //侧边栏区域
          drawer: Drawer(
            child: ListView(
              //去除应用自带的padding
              padding: EdgeInsets.all(0),
              children: <Widget>[
                UserAccountsDrawerHeader(
                  accountEmail: Text('https://github.com/chenzulu123'),
                  accountName: Text(
                    'David.chen',
                    style: TextStyle(fontSize: 20),
                  ),

                  //原型头像
                  currentAccountPicture: CircleAvatar(
                    //加载本地图片
                     backgroundImage: AssetImage('assets/images/icons.png')
                    //加载网络图片
                    // backgroundImage: NetworkImage(
                    //     'https://avatars2.githubusercontent.com/u/28553431?s=460&v=4'),
                  ),
                  //盒子的装饰器
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/images/bg.jpg'))),
                ),
                ListTile(
                  title: Text('用户反馈'),
                  trailing: Icon(Icons.feedback),
                  contentPadding: EdgeInsets.only(right: 50, left: 20),
                  onTap: (){
                    launch('https://github.com/chenzulu123/douban_movie/issues');
                  },
                ),
                ListTile(
                  title: Text('系统设置'),
                  trailing: Icon(Icons.settings),
                  contentPadding: EdgeInsets.only(right: 50, left: 20),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (BuildContext context) {
                      return Settings();
                    }));
                  },
                ),
                ListTile(
                  title: Text('我要发布'),
                  trailing: Icon(Icons.send),
                  contentPadding: EdgeInsets.only(right: 50, left: 20),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (BuildContext context) {
                      return Publish();
                    }));
                  },
                ),
                ListTile(
                  title: Text('关于'),
                  trailing: Icon(Icons.send),
                  contentPadding: EdgeInsets.only(right: 50, left: 20),
                  //路由跳转至关于页面
                  onTap: () {
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (BuildContext context) {
                    //   return About();
                    // }));
                    launch("https://github.com/chenzulu123/douban_movie/");
                  },
                ),
                // 分割线控件
                Divider(),
                ListTile(
                  title: Text('注销'),
                  trailing: Icon(Icons.exit_to_app),
                  //设置内边距
                  contentPadding: EdgeInsets.only(right: 50, left: 20),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              MovieList(mt: 'in_theaters'),
              MovieList(mt: 'coming_soon'),
              MovieList(mt: 'top250'),
            ],
          ),
          // 底部tab栏
          bottomNavigationBar: Container(
            //设置底部tab栏的背景颜色
            decoration: BoxDecoration(color: Color.fromRGBO(43, 152, 240, 1)),
            //一般高度都是50
            height: 60,
            child: TabBar(
              labelStyle: TextStyle(height: 0, fontSize: 10),
              
              tabs: <Widget>[
                Tab(
                  text: '正在热映',
                  icon: Icon(Icons.movie_filter),
                ),
                Tab(
                  text: '即将上映',
                  icon: Icon(Icons.movie_creation),
                ),
                Tab(
                  text: 'Top250',
                  icon: Icon(Icons.local_movies),
                )
              ],
            ),
            
          ),
        ));
  }
}