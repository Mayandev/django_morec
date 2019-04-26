import 'package:dio/dio.dart';
import 'dart:async';

import 'package:movie_recommend/public.dart';


class MorecApi {
  static const String baseUrl = 'http://127.0.0.1:8000/';

  var dio = MorecApi.createDio();

  // 用户注册
  Future<dynamic> register(String username, String password) async{
    var registerDio = MorecApi.createRegisterDio();
    Response<Map> response;
    var data = {
      "username": username,
      "password": password
    };
    try {
      response = await registerDio.post('user/', data: data);
    } catch (e) {
      Toast.show('用户名存在');
      return null;
    }
    return response;
  }

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

  // 判断当前电影是否被收藏
  Future<dynamic> isMovieFavor(String id) async{
    Response<Map> response;
    try {
      response = await dio.get('user_favor_movie/$id/');
    } catch (e) {
      // Toast.show('网络异常');
      return null;
    }
    return response.data;
  }

  // 判断当前演员是否被收藏
  Future<dynamic> isActorFavor(String id) async{
    Response<Map> response;
    try {
      response = await dio.get('user_favor_actor/$id/');
    } catch (e) {
      return null;
    }
    return response.data;
  }

  // 收藏该电影
  Future<dynamic> favorMovie(MovieDetail movie) async{
    Response<Map> response;
    var data = {
      'doubanId': movie.id, 
      'title': movie.title,
      'poster': movie.images.small
    };
    try {
      response = await dio.post('user_favor_movie/', data: data);
    } catch (e) {
      Toast.show('网络异常');
      return null;
    }
    return response.data;
  }

  // 取消收藏该电影
    Future<dynamic> cancelFavorMovie(String id) async{
    Response<Map> response;
    try {
      response = await dio.delete('user_favor_movie/$id/');
    } catch (e) {
      // Toast.show('网络异常');
      return null;
    }
    return response.data;
  }

  // 收藏该演员
  Future<dynamic> favorActor(MovieActorDetail actor) async{
    Response<Map> response;
    var data = {
      "actorId": actor.id,
      "name": actor.name,
      "avatar": actor.avatars.small
    };
    try {
      response = await dio.post('user_favor_actor/', data: data);
    } catch (e) {
      Toast.show('网络异常');
      return null;
    }
    return response.data;
  }

  // 取消收藏该演员
  Future<dynamic> cancelFavorActor(String id) async{
    Response<Map> response;
    try {
      response = await dio.delete('user_favor_actor/$id/');
    } catch (e) {
      // Toast.show('网络异常');
      return null;
    }
    return response;
  }

  // 查询用户的收藏的演员
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

    static Dio createRegisterDio() {
    var options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: 10000,
      receiveTimeout: 100000,
    );
    return Dio(options);
  }


}