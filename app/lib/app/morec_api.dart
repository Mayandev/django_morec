import 'package:dio/dio.dart';
import 'dart:async';

import 'package:movie_recommend/public.dart';


class MorecApi {
  static const String baseUrl = 'http://127.0.0.1:8000/';

  var dio = MorecApi.createDio();


  // 用户登陆
  Future<dynamic> login(String username, String password) async{
    Response<Map> response;
    try {
      response = await dio.post('login/', data: {'username': username, 'password': password});
    } catch (e) {
      print('账号密码错误');
      Toast.show('账号或密码错误');
      return null;
    }
    return response;
  }

  // 查询用户的收藏演员
  Future<dynamic> getFavorActorList() async{
    Response<List> response;
    try {
      response = await dio.get('user_favor_actor/');
    } catch (e) {
      Toast.show('网络异常');
      return null;
    }
    return response.data;
  }

    // 查询用户的收藏电影
  Future<dynamic> getFavorMovieList() async{
    Response<List> response;
    try {
      response = await dio.get('user_favor_movie/');
    } catch (e) {
      Toast.show('网络异常');
      return null;
    }
    return response.data;
  }

  static Dio createDio() {
    var options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: 10000,
      receiveTimeout: 100000,
      headers: {
        'Authorization': 'JWT ' + jwt
      }
    );
    return Dio(options);
  }
}