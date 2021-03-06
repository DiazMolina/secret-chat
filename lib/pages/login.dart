import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secret_chat/api/auth_api.dart';
import 'package:flutter_secret_chat/utils/responsive.dart';
import 'package:flutter_secret_chat/widgets/circle.dart';
import 'package:flutter_secret_chat/widgets/input.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _authAPI = AuthAPI();
  var _email = '', _password = '';
  var _isFetching = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  }

  _submit() async {
    if (_isFetching) return;
    final isValid = _formKey.currentState.validate();
    if (isValid) {
      setState(() {
        _isFetching = true;
      });
      final isOK =
          await _authAPI.login(context, email: _email, password: _password);
      setState(() {
        _isFetching = false;
      });
      if (isOK) {
        print('LOGIN IS OK');
        Navigator.pushNamedAndRemoveUntil(context, 'splash', (_)=>false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final responsive = Responsive(context);
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
                              width: responsive.wp(20),
                              height: responsive.hp(10),
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
                                    fontSize: responsive.ip(2), fontWeight: FontWeight.w300),
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
                                      fontSize: responsive.ip(2),
                                      validator: (String text) {
                                        if (text.contains("@")) {
                                          _email = text;
                                          return null;
                                        }
                                        return "Invalid Email";
                                      },
                                    ),
                                    SizedBox(height: 30),
                                    InputText(
                                      label: "Password",
                                      isSecure: true,
                                      fontSize: responsive.ip(2),
                                      validator: (String text) {
                                        if (text.isNotEmpty &&
                                            text.length > 5) {
                                          _password = text;
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
                                  padding: EdgeInsets.symmetric(vertical: responsive.ip(2)),
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
                                        fontSize: responsive.ip(1.8), color: Colors.black54)),
                                CupertinoButton(
                                    child: Text("Sing up",
                                        style: TextStyle(
                                            fontSize: responsive.ip(1.8),
                                            color: Colors.pinkAccent)),
                                    onPressed: () =>
                                        Navigator.pushNamed(context, "singup")),
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
