import 'package:derm_pro/models/auth.dart';
import 'package:derm_pro/registration_screens/email_page.dart';
import 'package:derm_pro/ui_elements/app_bar_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_entry_text_field/pin_entry_text_field.dart';
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

  @override
  void initState() {
    super.initState();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AuthMode _authMode = AuthMode.SignUp;

  Future<bool> _onBackedPress() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Log out'),
            content: Text('Are you sure you want to log out?'),
            actions: <Widget>[
              FlatButton(
                child: Text('NO'),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              FlatButton(
                child: Text('YES'),
                onPressed: () {
                  Navigator.of(context).pop(true);
                  /* Navigator.of(context).pushNamedAndRemoveUntil(
                      '/emailPage', (Route<dynamic> route) => false);*/
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      //  onWillPop: _onBackedPress,
        child: Scaffold(
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
                    child: Container(
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
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: 50,
                      height: 2,
                      color: Theme.of(context).backgroundColor,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    PinEntryTextField(
                      onSubmit: (String pin) {
                        setState(() {
                          _code = pin;
                        });
                      }, // onSubmit
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child:
                            (_onEditing != false) ? Container() : Container(),
                      ),
                    ),
                  ],
                ))),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                padding: EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(),
                    /* GestureDetector(
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
                )),*/
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
                        if (_code == "1234") {
                          print("helo check data of shared");
                          final SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          prefs.setString('token', _formData['token']);
                          prefs.setString('userEmail', _formData['email']);
                          prefs.setInt('userId', _formData['userId']);
                          prefs.setString('first_name', _formData['firstName']);
                          prefs.setString('last_name', _formData['lastName']);
                          prefs.setString('dob', _formData['dob']);
                          prefs.setString(
                              'contact_no', _formData['phoneNumber']);
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              '/welcomePage', (Route<dynamic> route) => false);
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
        )));
  }
}
