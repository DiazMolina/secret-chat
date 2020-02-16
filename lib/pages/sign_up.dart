import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secret_chat/api/auth_api.dart';
import 'package:flutter_secret_chat/widgets/circle.dart';
import 'package:flutter_secret_chat/widgets/input.dart';

class SingUpPage extends StatefulWidget {
  @override
  _SingUpPageState createState() => _SingUpPageState();
}

class _SingUpPageState extends State<SingUpPage> {
  final _formKey = GlobalKey<FormState>();
  var _username ='',_email='',_password='';
  final _authAPI = AuthAPI();
  var _isFetching = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  }

  _submit() async{
    if (_isFetching) return;
   final isValid= _formKey.currentState.validate();
    setState(() {
      _isFetching = true;
    });
   if(isValid){
     final isOK= await _authAPI.register(context,username:_username, email:_email, password: _password);
     setState(() {
       _isFetching = false;
     });
     if(isOK){
       print("Register");
       Navigator.pushNamedAndRemoveUntil(context, 'splash', (_)=>false);
     }
   }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
          width: size.width,
          height: size.height,
          child: Stack(
            children: <Widget>[
              Positioned(
                right: -size.width * 0.18,
                top: -size.width * 0.2,
                child: Circle(
                    radius: size.width * 0.42,
                    colors: [Colors.pink, Colors.pinkAccent]),
              ),
              Positioned(
                left: -size.width * 0.15,
                top: -size.width * 0.34,
                child: Circle(
                    radius: size.width * 0.35,
                    colors: [Colors.orange, Colors.deepOrange]),
              ),
              SingleChildScrollView(
                child: Container(
                  width: size.width,
                  height: size.height,
                  child: SafeArea(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Container(
                              width: 90,
                              height: 90,
                              child: Icon(
                                Icons.threed_rotation,
                                size: 60,
                              ),
                              margin: EdgeInsets.only(top: size.width * 0.32),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black26, blurRadius: 25)
                                  ]),
                            ),
                            SizedBox(height: 30),
                            Text("Hello again.\nWelcome back",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w300),
                                textAlign: TextAlign.center)
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth: 350,
                                minWidth: 350,
                              ),
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  children: <Widget>[
                                    InputText(
                                      label: "Username",
                                      validator: (String text) {
                                        if (RegExp(r'^[a-zA-Z0-9]+$').hasMatch(text)) {
                                          _username =text;
                                          return null;
                                        }
                                        return "Invalid Username";
                                      },
                                    ),
                                    SizedBox(height: 20),
                                    InputText(
                                      label: "Email Address",
                                      inputType: TextInputType.emailAddress,
                                      validator: (String text) {
                                        if (text.contains("@")) {
                                          _email=text;
                                          return null;
                                        }
                                        return "Invalid Email";
                                      },
                                    ),
                                    SizedBox(height: 20),
                                    InputText(
                                      label: "Password",
                                      isSecure: true,
                                      validator: (String text) {
                                        if (text.isNotEmpty &&
                                            text.length > 5) {
                                          _password=text;
                                          return null;
                                        }
                                        return "Invalid Password";
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 50),
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth: 350,
                                minWidth: 350,
                              ),
                              child: CupertinoButton(
                                  padding: EdgeInsets.symmetric(vertical: 17),
                                  color: Colors.pinkAccent,
                                  borderRadius: BorderRadius.circular(4),
                                  child: Text("Sing up",
                                      style: TextStyle(fontSize: 20)),
                                  onPressed: () => _submit()),
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text("Already have an account?",
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.black54)),
                                CupertinoButton(
                                    child: Text("Sing in",
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.pinkAccent)),
                                    onPressed: () =>Navigator.pop(context)),
                              ],
                            ),
                            SizedBox(height: size.height * 0.08)
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                  left: 15,
                  top: 5,
                  child: SafeArea(
                    child: CupertinoButton(
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                        color: Colors.black12,
                        padding: EdgeInsets.all(10),
                        borderRadius: BorderRadius.circular(30),
                        onPressed: () => Navigator.pop(context)),
                  )),
              //start feching dialog
              _isFetching? Positioned.fill(child: Container(
                color: Colors.black45,
                child: Center(
                  child: CupertinoActivityIndicator(radius: 15),
                ),
              )):Container()
            ],
          ),
        ),
      ),
    );
  }
}
