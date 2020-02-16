import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secret_chat/app_config.dart';
import 'package:flutter_secret_chat/utils/dialogs.dart';
import 'package:http/http.dart' as http;
class ProfileAPI{
  Future<dynamic>getUserInfo(BuildContext context,String token) async{
    try{
      final url ="${AppConfig.apiHost}/user-info";
      final response = await http.get(url,headers: {
        "token":token
      });
      final parsed =jsonDecode(response.body);
      if (response.statusCode==200){
        return parsed;

      }else if(response.statusCode==403){
        throw PlatformException(code: "403",message: parsed["message"]);
      }
      else if(response.statusCode==500){
        throw PlatformException(code: "403",message: parsed["message"]);
      }
      throw PlatformException(code: "201",message: "error user");
    } on PlatformException catch(e){
      print("error user info${e.message}");
      Dialogs.alert(context,title: "Error",message: e.message);
      return null;
    }
  }
}