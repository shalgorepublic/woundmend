import 'package:derm_pro/models/auth.dart';
import 'package:derm_pro/ui_elements/app_bar_line.dart';
import 'package:flutter/material.dart';
import 'dart:async';

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

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AuthMode _authMode = AuthMode.SignUp;
  String _verifyCode;

  @override
  void initState() {
    // TODO: implement initState
    print("otp in verification screen");
    print(_formData['otp']);
    super.initState();
  }

  void _submitForm() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
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
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).backgroundColor),
                  ),
                ),
                Container(
                  width: 50,
                  height: 2,
                  color: Theme.of(context).backgroundColor,
                ),
                Form(
                    key: _formKey,
                    child: Container(
                        padding: EdgeInsets.only(
                            bottom: 30, top: 30, right: 30, left: 30),
                        child: TextFormField(
                          textAlignVertical: TextAlignVertical.center,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue)),
                              labelText: 'Verification Code',
                              labelStyle: TextStyle(fontSize: 18),
                              filled: true,
                              fillColor: Colors.white),
                          keyboardType: TextInputType.number,
                          validator: (String value) {
                            if (value.isEmpty ||
                                value.length <= 3 ||
                                value.length > 4) {
                              // ignore: missing_return, missing_return
                              return 'Please enter 4 digit Code';
                            }
                          },
                          onSaved: (String value) {
                            _verifyCode = value;
                          },
                        ))),
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
                  onTap: () {
                    _submitForm();
                    //   if(_formData['otp'] == _verifyCode) {
                    if ('1234' == _verifyCode) {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          '/profilePage', (Route<dynamic> route) => false);
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
