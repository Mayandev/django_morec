import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:redux/redux.dart';
import 'package:redux_persist/redux_persist.dart';
import 'package:redux_persist_flutter/redux_persist_flutter.dart';


import 'package:movie_recommend/app/app_scence.dart';
import 'package:movie_recommend/app/app_state.dart';
import 'package:movie_recommend/public.dart';

void main() async{

  // 获取 jwt
  SharedPrefUtil prefUtil = new SharedPrefUtil();
  jwt = await prefUtil.getToken();

  // 创建一个持久化器
  final persistor = Persistor<AppState>(
    storage: FlutterStorage(),
    serializer: JsonSerializer<AppState>(AppState.fromJson),
    debug: true
  );

  // 从 persistor 中加载上一次存储的状态
  final initialState = await persistor.load();

  final store = Store<AppState>(
    reducer,
    initialState: initialState ?? AppState(''),
    middleware: [persistor.createMiddleware()]
  );
  runApp(AppScene(store));
  if (Platform.isAndroid) {
    // 设置沉浸式状态栏
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}