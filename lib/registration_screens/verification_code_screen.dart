import 'package:derm_pro/models/auth.dart';
import 'package:derm_pro/ui_elements/app_bar_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class VarificationScreen extends StatefulWidget {
  final Map<String, dynamic> formData;
  bool codeFlag = false;

  VarificationScreen(this.formData);

  @override
  _VarificationScreen createState() => _VarificationScreen(formData);
}

class _VarificationScreen extends State<VarificationScreen> {
  Map<String, dynamic> _formData;
  _VarificationScreen(this._formData);
  bool _onEditing = true;
  String _code;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AuthMode _authMode = AuthMode.SignUp;
//  String _verifyCode;

  @override
  void initState() {
    // TODO: implement initState
    print("otp in verification screen");
    print(_formData['otp']);
    print(_formData);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: <Widget>[
        Column(children: <Widget>[
          AppBarLine(),
          Container(
            padding: EdgeInsets.only(left: 40, right: 40, top: 30),
            child: Center(
              //child: Text("helo"),
              child: Image.asset(
                'assets/logo.png',
                width: 300,
                height: 150,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            decoration: new BoxDecoration(
              //new Color.fromRGBO(255, 0, 0, 0.0),
              borderRadius: new BorderRadius.all(Radius.circular(50)),
            ),
            child: Card(
                child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(
                    top: 20,
                    bottom: 10,
                  ),
                  child: Text(
                    "ENTER VERIFICATION CODE",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Bold',
                        color: Theme.of(context).backgroundColor),
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  width: 50,
                  height: 2,
                  color: Theme.of(context).backgroundColor,
                ),
                SizedBox(height: 20,),
                VerificationCode(
                  keyboardType: TextInputType.number,
                  length: 4,
                  autofocus: false,
                  onCompleted: (String value) {
                    setState(() {
                      _code = value;
                    });
                  },
                  onEditing: (bool value) {
                    setState(() {
                      _onEditing = value;
                    });
                  },
                ),
                SizedBox(height: 30,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: (_onEditing != false)
                        ? Container():Container(),
                  ),
                ),
              ],
            )),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            padding: EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                GestureDetector(
                    child: Container(
                  height: 50,
                  width: 50,
                  color: Theme.of(context).accentColor,
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                )),
                GestureDetector(
                  child: Container(
                    height: 50,
                    width: 130,
                    color: Theme.of(context).backgroundColor,
                    child: Row(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            "SUBMIT",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.white),
                          ),
                        ),
                        IconButton(
                            icon: Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                            ),
                            onPressed: () {}),
                      ],
                    ),
                  ),
                  onTap: () async {
                    //   if(_formData['otp'] == _verifyCode) {
                    if ('1234' ==_code) {
                      final SharedPreferences prefs = await SharedPreferences.getInstance();
                      prefs.setString('token' , _formData['auth_token']);
                      prefs.setString('userEmail' , _formData['userEmail']);
                      prefs.setInt('userId' , _formData['userId']);
                      prefs.setString('first_name' , _formData['first_name']);
                      prefs.setString('last_name' , _formData['last_name']);
                      prefs.setString('dob' , _formData['dob']);
                      prefs.setString('contact_no' , _formData['contact_no']);
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          '/welcomePage', (Route<dynamic> route) => false);
                      //     Navigator.of(context).pushReplacementNamed('/profilePage');
                    } else {
                      setState(() {
                        widget.codeFlag = true;
                      });
                      Timer(Duration(seconds: 3), () {
                        setState(() {
                          widget.codeFlag = false;
                        });
                      });
                    }
                  },
                )
              ],
            ),
          ),
          SizedBox(
            height: 40,
          ),
          widget.codeFlag
              ? Container(
                  padding: EdgeInsets.all(5),
                  child: Text("Invalid code"),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(
                            5.0) //                 <--- border radius here
                        ),
                  ),
                )
              : Container(),
        ])
      ],
    ));
  }
}
