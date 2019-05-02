import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:movie_recommend/public.dart';

import 'home_movie_recommendation_item.dart';

class MovieRecommendationView extends StatefulWidget {
  final String title;

  const MovieRecommendationView({Key key, this.title}) : super(key: key);

  @override
  _MovieRecommendationViewState createState() =>
      _MovieRecommendationViewState();
}

class _MovieRecommendationViewState extends State<MovieRecommendationView>
    with AutomaticKeepAliveClientMixin<MovieRecommendationView> {
  // var classifyMovieList;
  // var tagList;

  MorecApi api = new MorecApi();

  int page = 1;
  int pageSize = 5;
  bool isLoaded = false;
  List<MovieRecommendation> recommendations = [];

  @override
  Widget build(BuildContext context) {
    if (jwt == '') {
      return Container(
        color: Color(0xFFF5F5F5),
        padding: EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                AppNavigator.pushLogin(context);
              },
              child: Text(
                '点击登陆,',
                style: TextStyle(color: Colors.blue, fontSize: 14),
              ),
            ),
            Text(
              '为你进行个性化推荐',
              style: TextStyle(color: AppColor.grey, fontSize: 14),
            )
          ],
        ),
      );
    }
    if (recommendations.length == 0) {
      return CupertinoActivityIndicator();
    }
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(15, 15, 0, 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  this.widget.title,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  width: 80,
                  height: 2,
                  color: Colors.black,
                )
              ],
            ),
          ),
          ListView.builder(
            itemCount: recommendations.length,
            shrinkWrap: true, //解决无限高度问题
            physics: NeverScrollableScrollPhysics(), //禁用滑动事件

            itemBuilder: (BuildContext context, int index) {
              return MovieRecommendationItemView(
                doubanId: recommendations[index].doubanId,
                description: recommendations[index].description,
              );
            },
          ),
          Container(

            padding: EdgeInsets.all(10),
            child: Center(
              child: Offstage(
                offstage: isLoaded,
                child: GestureDetector(
                  onTap: () {
                    fetchData();
                  },
                  child: Text('加载更多', style: TextStyle(color: Colors.blue, fontSize: 14)),
                ),
              )
            ),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  // 加载数据
  Future<void> fetchData() async {
    List recommendationData = await api.getRecommendation(page, pageSize)??[];
    
    setState(() {
      List<MovieRecommendation> recommendationList =
          getRecommendationList(recommendationData);
      if (recommendationList.length == 0) {
        isLoaded = true;
        return;
      }

      recommendationList.forEach((movie) {
        recommendations.add(movie);
      });

      page = page + 1;
    });
  }

  List<MovieRecommendation> getRecommendationList(var list) {
    List content = list;
    List<MovieRecommendation> recommendations = [];
    content.forEach((data) {
      recommendations.add(MovieRecommendation.fromJson(data));
    });
    return recommendations;
  }

  @override
  bool get wantKeepAlive => true;
}
