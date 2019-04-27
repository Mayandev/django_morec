import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:movie_recommend/public.dart';

import 'register_scene.dart';

// app登陆页面
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  _LoginData _data = new _LoginData();
  final _formKey = GlobalKey<FormState>();
  MorecApi client = new MorecApi();
  SharedPrefUtil prefUtil = new SharedPrefUtil();

  // 提交表单登陆
  Future submit(Store<AppState> store) async {
    // First validate form.
    if (this._formKey.currentState.validate()) {
      _formKey.currentState.save(); // Save our form now.


      var response = await client.login(_data.username, _data.password);

      if (response != null) {
        store.dispatch(Actions.login);
        jwt = response.data['token'];
        prefUtil.setToken(jwt);
        prefUtil.setUserName(_data.username);
        Toast.show('登陆成功');
        back();
      }
      
    }
  }


  @override
  Widget build(BuildContext context) {
    final logo = CircleAvatar(
        radius: 50.0,
        backgroundImage: CachedNetworkImageProvider(myAvatarUrl)
      );

    final username = TextFormField(
      cursorColor: AppColor.darkGrey,
      keyboardType: TextInputType.text,
      autofocus: false,
      // initialValue: 'alucard@gmail.com',
      onSaved: (String value) {
        this._data.username = value;
      },
      validator: (value) {
        if (value.isEmpty) {
          return '请输入用户名';
        }
      },
      decoration: InputDecoration(
        hintText: '用户名',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))
      ),
    );

    final password = TextFormField(
      validator: (value) {
        if (value.isEmpty) {
          return '请输入密码';
        }
      },
      onSaved: (String value) {
        this._data.password = value;
      },
      cursorColor: AppColor.darkGrey,
      autofocus: false,
      // initialValue: 'some password',
      obscureText: true,
      decoration: InputDecoration(
        hintText: '密码',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))
      ),
    );

    final form = Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
            username,
            SizedBox(height: 8.0),
            password,
            SizedBox(height: 24.0),
        ],
      ),
    );

    final registerLabel = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('没有账号？', style: TextStyle(color: AppColor.grey, fontSize: 14),),
        GestureDetector(
          onTap: () {
            back();
            AppNavigator.push(context, RegisterScene());
          },
          child: Text(
            '点击注册',
            style: TextStyle(color: Colors.blue, fontSize: 14),
          ),
        ),
      ],
    );

    return StoreConnector<AppState, Store<AppState>>(
      converter: (store) => store,
      builder: (context, store) {
        return Scaffold(
          backgroundColor: Colors.white,
          resizeToAvoidBottomPadding: false,
          appBar: AppBar(
              brightness: Brightness.light,
              title: Text('登陆'),
              backgroundColor: AppColor.white,
              leading: GestureDetector(
                onTap: back,
                child: Image.asset('images/icon_arrow_back_black.png'),
              ),
              elevation: 0,
            ),
          body: Center(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Column(
                children: <Widget>[
                  logo,
                  SizedBox(height: 24.0),
                  form,
                  new SizedBox(
                    width: double.infinity,
                    child: new CupertinoButton(
                      pressedOpacity: 0.7,
                      padding: EdgeInsets.symmetric(vertical: 10),
                      color: AppColor.darkGrey,
                      child: Text('登陆'), 
                      onPressed: () {
                        submit(store);
                      },
                    ),
                  ),
                  SizedBox(height: 10,),
                  registerLabel
                ],
              )
            ),
          ),
        );
      },
    );
  }

    // 返回上个页面
  back() {
    Navigator.pop(context);
  }
}


class _LoginData {
  String username = '';
  String password = '';
}