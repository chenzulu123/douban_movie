import 'package:flutter/material.dart';
//加载请求工具
import 'package:dio/dio.dart';
Dio dio = new Dio();
//电影详情页
class MovieDetail extends StatefulWidget {
  MovieDetail({Key key, @required this.id, @required this.title})
      : super(key: key);
  final String id;
  final String title;
  _MovieDetailState createState() => _MovieDetailState();
}
class _MovieDetailState extends State<MovieDetail> {
  //电影详情
  var movieDetails = {};
  @override
  void initState() {
    super.initState();
    //获取电影详情
    getMovieDetail();
  }
  //获取电影详情
  getMovieDetail() async {
    //获取电影详情
    // print(widget.id);
    var response =
        await dio.get('http://api.douban.com/v2/movie/subject/${widget.id}');
    var result = response.data;
    // 设置获取的值
    if (result != null) {
      setState(() {
        movieDetails = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // print('movie------${movieDetail}');
    var detail = movieDetails;
    var summary="";
    var images={};
    var large="";
    summary = movieDetails['summary'];
    images = movieDetails['images'];
    large = images['large'];
    var info = movieDetails['year']+'/'+movieDetails['countries'].join('/')+'/'+movieDetails['genres'].join('/');
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 50, bottom: 30),
                color: Color.fromRGBO(23, 45, 74,1),
                child: Align(
                  child: Image.network(
                   movieDetails['images']['large'].toString(),
                    width: 200.0,
                  ),
                  alignment: Alignment.center,
                ),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 20, top: 20),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 20),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  '${widget.title}',
                                  softWrap: true,
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  info,
                                  softWrap: true,
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 20,top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                      child:Text('剧情简介',
                        softWrap: true,
                        ),
                    ),
                    Container(
                      padding: EdgeInsets.only(right: 20,top: 10),
                      child: 
                        Text(
                          summary,
                          maxLines: 40,
                          softWrap: true,
                        ),
                      
                    )
                  ],
                ),
              ),
            ],
          ),
        )
    );
  }
}
