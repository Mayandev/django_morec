import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:movie_recommend/public.dart';

class MovieRecommendationItemView extends StatefulWidget {
  final String doubanId;
  final String description;

  const MovieRecommendationItemView({Key key, this.doubanId, this.description}) : super(key: key);
  @override
  _MovieRecommendationItemViewState createState() => _MovieRecommendationItemViewState();
}

class _MovieRecommendationItemViewState extends State<MovieRecommendationItemView> {
  
  MovieDetail movie;

  @override
  void initState() {
    super.initState();
    fetchData();
  }
  
  @override
  Widget build(BuildContext context) {
    double imgWidth = 100;
    double height = imgWidth / 0.7;
    double spaceWidth = 15;
    if (movie == null) {
      return Container();
    }
    return GestureDetector(
      onTap: () {
        AppNavigator.pushMovieDetail(context, movie.id);
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(spaceWidth, spaceWidth, 0, spaceWidth),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(color: AppColor.lightGrey, width: 0.5)),
            color: AppColor.white),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            MovieCoverImage(
              movie.images.small,
              width: imgWidth,
              height: height,
            ),
            Container(
              padding: EdgeInsets.fromLTRB(spaceWidth, 0, spaceWidth, 0),
              width: Screen.width - imgWidth - spaceWidth * 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    movie.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      new StaticRatingBar(
                        size: 13.0,
                        rate: movie.rating.average / 2,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        movie.rating.average.toString(),
                        style: TextStyle(color: AppColor.grey, fontSize: 12.0),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    '${movie.year} /${genres2String(movie.genres)}/${actor2String(movie.directors)}/${actor2String(movie.casts)}',
                    style: TextStyle(color: AppColor.grey, fontSize: 14),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 10,),
                  Container(
                    padding: EdgeInsets.all(10),
                    width: Screen.width - imgWidth - spaceWidth * 4,
                    color: Color(0xfff2f2f2),
                    child: Text(this.widget.description, style: TextStyle(color: AppColor.grey, fontSize: 14))
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }



  String actor2String(List<MovieActor> actors) {
    StringBuffer sb = new StringBuffer();
    actors.forEach((actor) {
      sb.write(' ${actor.name} ');
    });
    return sb.toString();
  }

  String genres2String(List genres) {
    StringBuffer sb = new StringBuffer();
    genres.forEach((genre) {
      sb.write(' $genre ');
    });
    return sb.toString();
  }


  Future<void> fetchData() async{
    ApiClient client = new ApiClient();
    MovieDetail data =
        MovieDetail.fromJson(await client.getMovieDetail(this.widget.doubanId));

    setState(() {
      movie = data;
    });
    
  }
}