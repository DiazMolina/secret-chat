import 'package:flutter/material.dart';
import 'package:flutter_secret_chat/pages/home.dart';
import 'package:flutter_secret_chat/pages/login.dart';
import 'package:flutter_secret_chat/pages/sign_up.dart';
import 'package:flutter_secret_chat/pages/splash.dart';
import 'package:flutter_secret_chat/providers/me.dart';
import 'package:provider/provider.dart';
void main(){
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(
        builder: (_)=>Me(),
      )
    ],
      child: MaterialApp(
        title: 'flutter secret chat',
        debugShowCheckedModeBanner: false,
        home: SplashPage(),
        routes: {
          "splash":(context)=>SplashPage(),
          "login":(context)=>LoginPage(),
          "singup":(context)=> SingUpPage(),
          "home":(context)=>HomePage()

        },
      ),
    );
  }
}
