import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secret_chat/widgets/circle.dart';
import 'package:flutter_secret_chat/widgets/input.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  }

  _submit() {
    _formKey.currentState.validate();
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
                              height: 90,child: Icon(Icons.threed_rotation,size: 60,),
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
                                      label: "Email Address",
                                      inputType: TextInputType.emailAddress,
                                      validator: (String text) {
                                        if (text.contains("@")) {
                                          return null;
                                        }
                                        return "Invalid Email";
                                      },
                                    ),
                                    SizedBox(height: 30),
                                    InputText(
                                      label: "Password",
                                      isSecure: true,
                                      validator: (String text) {
                                        if (text.isNotEmpty &&
                                            text.length > 5) {
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
                                  child: Text("Sing in",
                                      style: TextStyle(fontSize: 20)),
                                  onPressed: () => _submit()),
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text("New to Friendly?",
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.black54)),
                                CupertinoButton(
                                    child: Text("Sing up",
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.pinkAccent)),
                                    onPressed: () {}),
                              ],
                            ),
                            SizedBox(height: size.height * 0.08)
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
