import 'package:derm_pro/registration_screens/login_password_screen.dart';
import 'package:derm_pro/ui_elements/app_bar_line.dart';
import 'package:flutter/material.dart';
import '../registration_screens/signup.dart';

class EmailPage extends StatefulWidget {
  @override
  _EmailPageState createState() => _EmailPageState();
}

class _EmailPageState extends State<EmailPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email = null;
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
            padding: EdgeInsets.only(left: 40, right: 40, top: 80),
            child: Center(
              //child: Text("helo"),
              child: Image.asset(
                'assets/logo.png',
                width: 300,
                height: 150,
              ),
            ),
          ),
      Form(
          key: _formKey,
          child:
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
                  padding: EdgeInsets.only(top: 20, bottom: 10),
                  child: Text(
                    "Enter Your Email to Login",
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Bold',
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
                    child: TextFormField(
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
                        _email = value;
                      },
                    )),
              ],
            )),
          )
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
                          if(_formKey.currentState.validate()) {
                            Navigator.push<dynamic>(
                              context ,
                              MaterialPageRoute<dynamic>(
                                  builder: (context) => PasswordScreen(_email),) ,
                            );
                          }
                        },
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 40,),
          Container(
            width: 250,
            height: 40,
            child: RaisedButton(
              elevation: 4,
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              color: Theme.of(context).accentColor,
              child: FittedBox(
                child: Row(
                  children: <Widget>[
                    Text(
                      '- - - - - - -',
                      style: TextStyle(fontSize: 12),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 60),
                      child: Text('SIGNUP',style: TextStyle( fontWeight: FontWeight.bold ,
                          fontSize: 18 ,fontFamily: 'Bold'),),
                    ),
                    Text(
                      '- - - - - - -',
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
              textColor: Colors.white,
              onPressed: () {
                Navigator.pushNamed(context, '/signup');
              },
            ),
          )

        ])
      ],
    ));
  }
}
