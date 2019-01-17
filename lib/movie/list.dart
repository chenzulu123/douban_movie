import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../movie/detail.dart';
// import 'dart:convert';
import 'dart:ui';

//创建请求数据的变量
Dio dio = new Dio();

class MovieList extends StatefulWidget {
  MovieList({Key key, @required this.mt}) : super(key: key);
  //电影类型
  final String mt;
  _MovieListState createState() => _MovieListState();
}

//保持页面切换时不被改变
class _MovieListState extends State<MovieList>
    with AutomaticKeepAliveClientMixin {

  bool isPerformingRequest = false;
  bool isLoading = false;

  @override
  bool get wantKeepAlive => true;

  _MovieListState(){
    addListener();
  }

  //默认
  int page = 1;
  int pageSize = 10;
  var mlist = [];
  var total = 0;

  //监听屏幕滚动
  ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();
    getMovieList();
    
  }

  void addListener(){
    _scrollController.addListener(() {
      // print('_scrollController');
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        
        if (!isPerformingRequest) 
        _getMore();
       
        // print(page);
        // getMovieList();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  //下拉刷新数据的实现
  Future<Null> _refresh() async {
    // 清除原有数据
    mlist.clear();
    // 重新请求数据
    await getMovieList();
    return;
  }


  //渲染当前控件
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        //绑定下拉实现是方法
        onRefresh: _refresh,
        child: ListView.builder(
          itemCount: mlist.length,
          itemBuilder: (BuildContext context, int i) {
            var mitem = mlist[i];
            // print(mitem);
            var castsArr = mitem['casts'];
            var casts = [];
            for (var i = 0; i < castsArr.length; i++) {
              casts.add(castsArr[i]['name']);
            }
            return GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return MovieDetail(
                      id: mitem['id'],
                      title: mitem['title'],
                    );
                  }));
                },
                child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(top: BorderSide(color: Colors.black12))),
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: 20.0),
                        ),
                        Image.network(
                          mitem['images']['small'],
                          width: 130.0,
                          height: 180.0,
                          fit: BoxFit.cover,
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.only(left: 10,right: 20),
                            height: 200,
                            // width:,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Text(
                                  '${mitem['title']}',
                                  maxLines: 4,
                                  // overflow: TextOverflow.ellipsis,
                                  softWrap: true,
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text('主演：${casts.join('/')}',
                                    softWrap: true, maxLines: 4),
                                Text('上映年份：${mitem['year']}',
                                    overflow: TextOverflow.ellipsis),
                                Text('电影类型：${mitem['genres'].join('/')}',
                                    overflow: TextOverflow.ellipsis),
                                Text('豆瓣评分：${mitem['rating']['average']}分',
                                    overflow: TextOverflow.ellipsis),
                                Text('导演：${mitem['directors'][0]['name']}',
                                    overflow: TextOverflow.ellipsis),
                              ],
                            ),
                          ),
                        )
                      ],
                    )));
          },
        ));
  }

  getMovieList() async {
    // print(page);
    if (!isPerformingRequest) {
      setState(() => isPerformingRequest = true);
    }
    isLoading = false;
    int offSet = (page - 1) * pageSize;
    var response = await dio.get(
      
        'http://api.douban.com/v2/movie/${widget.mt}?start=$offSet&count=$pageSize');

    var result = response.data;
    setState(() {
      if(result.isEmpty){
        isPerformingRequest = true;
      }else{
        mlist.addAll(result['subjects']);
        total = result['total'];
      }
    });
  }

   /// 上拉加载更多
  _getMore() {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });
      page++;
      getMovieList();
    }
  }
  //加载中的组件
  Widget _getMoreWidget() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              '加载中...',
              style: TextStyle(fontSize: 16.0),
            ),
            CircularProgressIndicator(strokeWidth: 1.0,)
          ],
        ),
      ),
    );
  }
}
