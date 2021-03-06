import 'package:derm_pro/registration_screens/signup_password_screen.dart';
import 'package:derm_pro/ui_elements/app_bar_line.dart';
import 'package:flutter/material.dart';
import './email_page.dart';

class SecondEmailPage extends StatefulWidget {
  final Map<String, dynamic> _formData;

  SecondEmailPage(this._formData);

  @override
  _SecondEmailPageState createState() => _SecondEmailPageState(_formData);
}

class _SecondEmailPageState extends State<SecondEmailPage> {
  Map<String, dynamic> _formdata;

  _SecondEmailPageState(this._formdata);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email = null;

  void _submitForm() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    _formdata = {
      'firstName': _formdata['firstName'],
      'lastName': _formdata['lastName'],
      'email': _email
    };
  }

  bool promoflag = false;

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
              child: Image.asset(
                'assets/logo.png',
                width: 300,
                height: 100,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            decoration: new BoxDecoration(
              borderRadius: new BorderRadius.all(Radius.circular(50)),
            ),
            child: Card(
                child: Column(
              children: <Widget>[
                Container(
                  padding:
                      EdgeInsets.only(top: 30, bottom: 20, left: 10, right: 10),
                  child: Text(
                    "Enter your email to receive results about your health",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Bold',
                        color: Theme.of(context).accentColor),
                  ),
                ),
                Container(
                  width: 50,
                  height: 2,
                  color: Theme.of(context).accentColor,
                ),
                Form(
                  key: _formKey,
                  child: Container(
                    margin: const EdgeInsets.only(right: 30, left: 30),
                    padding: EdgeInsets.only(bottom: 40, top: 20),
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4)),
                                borderSide: BorderSide(
                                    width: 1,
                                    color: Theme.of(context).accentColor),
                              ),
                              border: OutlineInputBorder(
                                  borderSide: new BorderSide()),
                              labelText: 'E-mail',
                              labelStyle: TextStyle(color: Theme.of(context).accentColor),
                              filled: true,
                              fillColor: Colors.white),
                          keyboardType: TextInputType.emailAddress,
                          validator: (String value) {
                            if (value.isEmpty ||
                                // ignore: missing_return
                                !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                                    .hasMatch(value)) {
                              // ignore: missing_return, missing_return
                              return 'Please enter a valid e-mail';
                            }
                          },
                          onSaved: (String value) {
                            _email = value;
                          },
                        ),
                        /* promoflag ?
                                  Container(padding:EdgeInsets.only(top: 10),child:
                              TextFormField(
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.blue)),
                                    labelText: 'Promo Code',
                                    filled: true,
                                    fillColor: Colors.white),
                                keyboardType: TextInputType.emailAddress,
                                validator: (String value) {
                                  if (value.isEmpty ||
                                      // ignore: missing_return
                                      !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                                          .hasMatch(value)) {
                                    // ignore: missing_return, missing_return
                                    return 'Please enter a valid email';
                                  }
                                },
                                onSaved: (String value) {
                                  // _formData['email'] = value;
                                },
                              )
                                  ):
                                  Container(),*/
                      ],
                    ),
                  ),
                ),
              ],
            )),
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
                    width: 50,
                    color: Theme.of(context).backgroundColor,
                    child: IconButton(
                        icon: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          _submitForm();
                          if (_formKey.currentState.validate()) {
                            Navigator.push<dynamic>(
                              context,
                              MaterialPageRoute<dynamic>(
                                  builder: (context) =>
                                      PasswordScreen(_formdata)),
                            );
                          }
                        }),
                  ),
                )
              ],
            ),
          ),
          /* Container(
                padding: EdgeInsets.only(top: 70,bottom: 40),
                child: SizedBox(
                  width: 250.0,
                  height: 40.0,
                  child: new RaisedButton(
                    color: Theme.of(context).backgroundColor,
                    shape: new RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    child: Text(
                      'I HAVA A PROMO CODE',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.white),
                    ),
                    onPressed: (){print("pressed me");
                    setState(() {
                      promoflag = true;
                    });
                    },
                    */ /* onPressed: () {
                      Navigator.push<dynamic>(
                        context,
                        MaterialPageRoute<dynamic>(
                            builder: (context) => SignupScreen()),
                      );
                    },*/ /*
                  ),
                ),
              ),*/
        ])
      ],
    ));
  }
}
