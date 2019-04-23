import 'package:flutter/material.dart';

import 'package:movie_recommend/public.dart';

import 'cover_image_view.dart';

class FavorActorView extends StatelessWidget {
  final List<MovieActor> actors;

  FavorActorView(this.actors);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Scrollbar(
        child: GridView.builder(
          addAutomaticKeepAlives: true,
          itemCount: actors.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3/4,
          ), 
          itemBuilder: (BuildContext context, int index) {
            return FavorActorCoverView(actors[index]);
          },
          
        ),
      )
    );
  }
}

class FavorActorCoverView extends StatelessWidget {
  final MovieActor actor;

  FavorActorCoverView(this.actor);


  @override
  Widget build(BuildContext context) {
    // 单个电影的宽度
    // 一行放置 2 个 演员头像
    var width = Screen.width / 2;

    return GestureDetector(
      onTap: () {
        AppNavigator.pushActorDetail(context, actor);
      },
      child: Container(
        width: width,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            CoverImageView(actor.avatars.small, width: width, height: width / 0.75,),
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
                    actor.name, style: TextStyle(color: AppColor.white, fontSize: 16,), 
                    overflow: TextOverflow.ellipsis,),
                ),
              ),
            )
            // SizedBox(height: 5,),
            // Text(
            //   actor.name,
            //   overflow: TextOverflow.ellipsis,
            //   style: TextStyle(fontSize: 14, color: Color(0xff5b5b5b)),
            //   maxLines: 1,
            // ),
          ],
        ),
      ),
    );
  }
}