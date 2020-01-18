import 'package:derm_pro/registration_screens/name_screen.dart';
import 'package:derm_pro/registration_screens/signup_password_screen.dart';
import 'package:flutter/material.dart';

class SecondEmailPage extends StatefulWidget {
  @override
  _SecondEmailPageState createState() => _SecondEmailPageState();
}

class _SecondEmailPageState extends State<SecondEmailPage> {
    bool promoflag = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
          children: <Widget>[
            Column(children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 40, right: 40, top: 30),
                child: Center(
                  //child: Text("helo"),
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
                          padding: EdgeInsets.only(top: 20, bottom: 10),
                          child: Text(
                            "At which email do you want to receive result about your health?",
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
                        Container(
                            margin: const EdgeInsets.only(right: 10, left: 10),
                            padding: EdgeInsets.only(bottom: 20, top: 20),
                            child:Column(children: <Widget>[
                              TextFormField(
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.blue)),
                                    labelText: 'E-Mail',
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
                              ),
                              promoflag ?
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
                              )):
                                  Container(),
                            ],),
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
                            Navigator.push<dynamic>(
                              context,
                              MaterialPageRoute<dynamic>(
                                  builder: (context) => PasswordScreen()),
                            );
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 20),
                child: SizedBox(
                  width: 220.0,
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
                    /* onPressed: () {
                      Navigator.push<dynamic>(
                        context,
                        MaterialPageRoute<dynamic>(
                            builder: (context) => SignupScreen()),
                      );
                    },*/
                  ),
                ),
              ),

              Container(
                padding: EdgeInsets.only(top: 30),
                child: SizedBox(
                  width: 220.0,
                  height: 40.0,
                  child: new RaisedButton(
                    color: Theme.of(context).accentColor,
                    shape: new RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    child: Text(
                      'LOGIN',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.white),
                    ),
                   onPressed: (){print("pressed me");},
                   /* onPressed: () {
                      Navigator.push<dynamic>(
                        context,
                        MaterialPageRoute<dynamic>(
                            builder: (context) => SignupScreen()),
                      );
                    },*/
                  ),
                ),
              ),
            ])
          ],
        ));
  }
}
