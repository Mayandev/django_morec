import 'package:flutter/material.dart';

import 'package:movie_recommend/model/movie_item.dart';
import 'package:movie_recommend/public.dart';

class FavorMovieView extends StatelessWidget {
  final List<MovieItem> movies;

  FavorMovieView(this.movies);

  @override
  Widget build(BuildContext context) {


    var children = movies.map((movie) => 
          FavorMovieCoverView(movie)).toList();

    return Container(
      color: Colors.white,
      child: Container(
            padding: EdgeInsets.fromLTRB(15, 10, 0, 10),
            child: Wrap(spacing: 15, runSpacing: 20, children: children,),
      ),
    );
  }
}

class FavorMovieCoverView extends StatelessWidget {
  final MovieItem movie;

  FavorMovieCoverView(this.movie);


  @override
  Widget build(BuildContext context) {
    // 单个电影的宽度
    // 一行放置 3 个 电影
    var width = (Screen.width - 15 * 4) / 3;

    return GestureDetector(
      onTap: () {
        AppNavigator.pushMovieDetail(context, movie);
      },
      child: Container(
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            MovieCoverImage(movie.images.small, width: width, height: width / 0.75,),
            SizedBox(height: 5,),
            Text(
              movie.title,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 14, color: Color(0xff5b5b5b)),
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }
}