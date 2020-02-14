import 'package:flutter/material.dart';
import 'package:flutter_secret_chat/pages/login.dart';
void main(){
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'flutter secret chat',
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
