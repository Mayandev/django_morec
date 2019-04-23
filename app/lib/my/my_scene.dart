import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/services.dart';


import 'package:movie_recommend/public.dart';
import 'favor_movie_view.dart';
import 'favor_actor_view.dart';

class MyScene extends StatefulWidget {
  _MySceneState createState() => _MySceneState();
}

class _MySceneState extends State<MyScene>
    with RouteAware, SingleTickerProviderStateMixin {
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

  @override
  void deactivate() {
    print('deactivate');
    fetchData();
    super.deactivate();
  }

  Future<void> fetchData() async {
    String name = await prefUtil.getUserName();
    MorecApi api = new MorecApi();
    List movieList = await api.getFavorMovieList();
    List actorList = await api.getFavorActorList();

    setState(() {
      username = name;
      favorMovies = list2Movie(movieList);
      favorActors = list2Actor(actorList);
    });
  }

  List<MovieItem> list2Movie(List list) {
    List<MovieItem> movies = [];
    list.forEach((item) {
      MovieItem movie = new MovieItem(
          id: item['doubanId'],
          title: item['title'],
          images: MovieImage(small: item['poster']));
      movies.add(movie);
    });
    return movies;
  }

  List<MovieActor> list2Actor(List list) {
    List<MovieActor> actors = [];
    list.forEach((item) {
      MovieActor actor = new MovieActor(
          id: item['actorId'],
          name: item['name'],
          avatars: MovieImage(small: item['avatar']));
      actors.add(actor);
    });
    return actors;
  }

  @override
  Widget build(BuildContext context) {
    print('build_myscene');
    return Scaffold(
      appBar: AppBar(
        title: Text('我的收藏', style: TextStyle(color: AppColor.white),),
        elevation: 0,
        backgroundColor: AppColor.darkGrey,
        brightness: Brightness.dark,
      ),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool boxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              brightness: Brightness.dark,
              pinned: true,
              backgroundColor: AppColor.darkGrey,
              forceElevated: boxIsScrolled,
              elevation: 0,
              floating: true,
              expandedHeight: 200.0,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  decoration: BoxDecoration(
                    color: AppColor.darkGrey
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: MediaQuery.of(context).padding.top,
                      ),
                      CircleAvatar(
                        radius: 50,
                        backgroundImage:
                            CachedNetworkImageProvider(myAvatarUrl),
                      ),
                      Container(
                        height: 8.0,
                      ),
                      Text(
                        username ?? '',
                        style: TextStyle(color: AppColor.white, fontSize: 18),
                      ),
                      Container(
                        height: 16.0,
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
            FavorActorSection(favorActors)
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
    if (movies == null || movies.length == 0) {
      return Center(
        child: Column(
          children: <Widget>[
            Image.asset('images/icon_nothing.png', width: 100, height: 100,),
            SizedBox(height: 10,),
            Text('空空如也，去首页看看吧！', style: TextStyle(color: AppColor.lightGrey, fontSize: 14),)
          ],
        ),
      );
    }
    return FavorMovieView(movies);
  }
}

class FavorActorSection extends StatelessWidget {
  final List<MovieActor> actors;
  FavorActorSection(this.actors);

  @override
  Widget build(BuildContext context) {
    if (actors == null || actors.length == 0) {
      return Center(
        child: Column(
          children: <Widget>[
            Image.asset('images/icon_nothing.png', width: 100, height: 100,),
            SizedBox(height: 10,),
            Text('空空如也，去首页看看吧！', style: TextStyle(color: AppColor.darkGrey, fontSize: 14),)
          ],
        ),
      );
    }
    return FavorActorView(actors);
  }
}
