import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/services.dart';


import 'dart:ui' as ui;

import 'package:movie_recommend/public.dart';
import 'login_scene.dart';
import 'favor_movie_view.dart';

class MyScene extends StatefulWidget {
  _MySceneState createState() => _MySceneState();
}

class _MySceneState extends State<MyScene> with RouteAware, SingleTickerProviderStateMixin{

  SharedPrefUtil prefUtil = new SharedPrefUtil();
  String username;

  TabController _tabController;
  ScrollController _scrollViewController;

  List<MovieItem> favorMovies;
  List<MovieActor> favorActors;


  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
    _scrollViewController = ScrollController(initialScrollOffset: 0.0);
    print('init my scene');
    fetchData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollViewController.dispose();
    super.dispose();
  }

  Future<void> fetchData() async {
    String name = await prefUtil.getUserName();
    MorecApi api = new MorecApi();
    List movieList = await api.getFavorMovieList();

    setState(() {
      username = name;
      favorMovies = list2Movie(movieList);
    });
  }

  List<MovieItem> list2Movie(List list) {
    List<MovieItem> movies = [];
    list.forEach((item) {
      MovieItem movie = new MovieItem(id: item['doubanId'], title: item['title'], 
        images: MovieImage(small:item['poster']));
      movies.add(movie);
    });
    return movies;
  }


  @override
  Widget build(BuildContext context) {
    print('build_myscene');
    return Scaffold(
        body: NestedScrollView(
          controller: _scrollViewController,

          headerSliverBuilder: (BuildContext context, bool boxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                brightness: Brightness.dark,
                
                pinned: true,
                backgroundColor: AppColor.darkGrey,
                forceElevated: boxIsScrolled,
                elevation: 0,
                floating: true,
                expandedHeight: 250.0,
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    child: Stack(
                      children: <Widget>[
                        Image(
                          image: CachedNetworkImageProvider(myAvatarUrl),
                          fit: BoxFit.cover,
                          width: Screen.width,
                          height: 300,
                        ),
                        Opacity(
                          opacity: 0.7,
                          child: Container(
                              color: Colors.black, width: Screen.width, height: 300),
                        ),
                        BackdropFilter(
                          filter: ui.ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                          child: Container(
                              width: Screen.width,
                              height: 300,
                              color: Colors.transparent,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () {
                                      AppNavigator.push(context, LoginPage());
                                    },
                                    child: CircleAvatar(
                                      backgroundImage: CachedNetworkImageProvider(myAvatarUrl),
                                      radius: 50.0,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(username??'',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: AppColor.white,
                                      ))
                                ],
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
                bottom: TabBar(
                  labelColor: AppColor.white,
                  indicatorColor: AppColor.white,
                  controller: _tabController,
                  tabs: <Widget>[
                    Tab(
                      text: "电影",
                      icon: Icon(Icons.movie_filter),
                    ),
                    Tab(
                      text: "演员",
                      icon: Icon(Icons.recent_actors),
                    ),
                  ],
                ),
              )
            ];
          },
          body: TabBarView(
            children: <Widget>[
              FavorMovieSection(favorMovies),
              FavorActorSection()
            ],
            controller: _tabController,
          ),
        ),
      );
  }


}
class FavorMovieSection extends StatelessWidget {

  final List<MovieItem> movies;

  FavorMovieSection(this.movies);

  @override
  Widget build(BuildContext context) {
    if (movies == null) {
      return  Center(
        child: CupertinoActivityIndicator(),
      );
    }
    return FavorMovieView(movies);
  }
}

class FavorActorSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
