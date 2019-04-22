import 'package:flutter/material.dart';
import 'package:movie_recommend/public.dart';
import 'package:movie_recommend/app/root_scene.dart';

import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'app_state.dart';

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();


class AppScene extends StatelessWidget {

  final Store<AppState> store;

  const AppScene(this.store);
  
  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: MaterialApp(
        title: 'MoRec',
        navigatorObservers: [routeObserver],
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.white,
          dividerColor: Color(0xFFEEEEEE),
          scaffoldBackgroundColor: AppColor.paper,
          textTheme: TextTheme(
            body1: TextStyle(color: AppColor.darkGrey)
          )
        ),
        home: RootScene(),
      ),
    );
  }
}