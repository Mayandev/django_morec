import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefUtil {

  final String tokenPrefs = "token";
  final String usernamePrefs = 'username';

  Future<bool> setToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.setString(tokenPrefs, token);
  }

  Future<String> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getString(tokenPrefs) ?? '';
  }

  Future<bool> setUserName(String username) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.setString(usernamePrefs, username);
  }

  Future<String> getUserName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(usernamePrefs) ?? '未登录';
  }



}