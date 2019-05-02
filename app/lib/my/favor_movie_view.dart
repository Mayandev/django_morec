import 'package:flutter/material.dart';

import 'package:movie_recommend/public.dart';

import 'cover_image_view.dart';


class FavorMovieView extends StatelessWidget {
  final List<MovieItem> movies;

  FavorMovieView(this.movies);

  @override
  Widget build(BuildContext context) {


    return Container(
      color: Colors.white,
      child: Scrollbar(
        child: GridView.builder(
          addAutomaticKeepAlives: true,
          itemCount: movies.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3/4,
          ), 
          itemBuilder: (BuildContext context, int index) {
            return FavorMovieCoverView(movies[index]);
          },
          
        ),
      )
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
    var width = Screen.width/2;

    return GestureDetector(
      onTap: () {
        AppNavigator.pushMovieDetail(context, movie.id);
      },
      child: Container(
        width: width,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            CoverImageView(movie.images.small, width: width, height: width / 0.75,),
            Opacity(
              opacity: 0.8,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                ),
                height: 40,
                width: width,
                child: Center(
                  child: Text(
                    movie.title, style: TextStyle(color: AppColor.white, fontSize: 16,), 
                    overflow: TextOverflow.ellipsis,),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}