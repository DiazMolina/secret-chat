import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secret_chat/api/auth_api.dart';
import 'package:flutter_secret_chat/api/profile_api.dart';
import 'package:flutter_secret_chat/models/user.dart';
import 'package:flutter_secret_chat/providers/me.dart';
class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final _authAPI = AuthAPI();
  final _profileAPI = ProfileAPI();
  Me _me ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.check();
  }
  check()async{
    final token = await _authAPI.getAccesToken();
    if(token!=null){
      final result =await _profileAPI.getUserInfo(context, token);
      final user = User.fromJson(result);
      print('id:${user.id}');
      print('email:${user.email}');
      print('user to json:${user.toJson()}');
      _me.data =user;
      Navigator.pushReplacementNamed(context, "home");
    }else{
      Navigator.pushReplacementNamed(context, "login");
    }
  }
  @override
  Widget build(BuildContext context) {
    _me = Me.of(context);
    return Scaffold(
      body: Center(child: CupertinoActivityIndicator(radius: 15),),
    );
  }
}
