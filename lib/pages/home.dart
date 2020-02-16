import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secret_chat/models/user.dart';
import 'package:flutter_secret_chat/providers/me.dart';
import 'package:flutter_secret_chat/utils/dialogs.dart';
import 'package:flutter_secret_chat/utils/session.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Me _me;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  _onExit(){
  Dialogs.confirm(context,title: "Confirm",message: 'Are you sure?',onCancel: (){
    Navigator.pop(context);
  },onConfirm: () async{
    Navigator.pop(context);
    Session session = Session();
    await session.clear();
    Navigator.pushNamedAndRemoveUntil(context, 'login', (_)=>false);
    });

  }
  @override
  Widget build(BuildContext context) {
    _me=Me.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        brightness: Brightness.light,
        actions: <Widget>[
          PopupMenuButton(icon: Icon(Icons.more_vert,color: Colors.black,),
            onSelected: (String value){
            if(value =='exit'){
              _onExit();
            }
            },
            itemBuilder: (context)=>[
            PopupMenuItem(child: Text('Share App'),
            value: 'Sahe',),
              PopupMenuItem(child: Text('Exit App'),
                value: 'exit',)
            ],
          )
        ],
      ),
      body: Center(child: Text(_me.data.toJson().toString()),),
    );
  }
}
