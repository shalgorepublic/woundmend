import 'package:derm_pro/registration_screens/forgot_password_success.dart';
import 'package:derm_pro/scoped_models/main.dart';
import 'package:derm_pro/ui_elements/app_bar_line.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class ForgotPasswordScreen extends StatelessWidget {
  final email;
  ForgotPasswordScreen(this.email);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
   String  _email = null;
  @override
  Widget build(BuildContext context) {
    void _submitForm(Function forgotPassword) async {
      if (!_formKey.currentState.validate()) {
        return;
      }
      _formKey.currentState.save();
      Map<String, dynamic> successInformation;
      successInformation = await forgotPassword(_email);
      if(successInformation['success']){
        if (successInformation['message'] == 'Password sent to email') {
          Navigator.push<dynamic>(
            context ,
            MaterialPageRoute<dynamic>(
              builder: (context) => ForgotPasswordSuccessScreen(_email),) ,
          );
        } else {
          showDialog<dynamic>(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Alert'),
                content: Text(successInformation['message']),
                actions: <Widget>[
                  FlatButton(
                    child: Text('Okey'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              );
            },
          );
        }
      }
      else
        showDialog<dynamic>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Alert'),
              content: Text("Some thing went wrong"),
              actions: <Widget>[
                FlatButton(
                  child: Text('Okey'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          },
        );
    }
    return Scaffold(
        body: SafeArea(child:
        ListView(
      children: <Widget>[
        AppBarLine(),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(top: 60),
              child: Text(
                "Forgot your password?",
                style: TextStyle(fontSize: 24, color: Colors.black54),
              ),
            ),
            Container(
              alignment: Alignment.topCenter,
              padding: EdgeInsets.only(top: 20, left: 30, right: 30),
              child: Text(
                "Enter your email address and we will send you a link to reset your password.",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
                padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                alignment: Alignment.center,
                child: Card(
                    child:
                    Form(
                        key: _formKey,
                        child:
                        Container(
                          padding: EdgeInsets.all(20),
                          decoration: new BoxDecoration(
                            //new Color.fromRGBO(255, 0, 0, 0.0),
                            borderRadius: new BorderRadius.all(Radius.circular(50)),
                          ),
                          child: Column(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.only(top: 20, bottom: 10),
                                    child: Text(
                                      "Enter Your Email",
                                      style: TextStyle(
                                          fontSize: 18,
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
                                      child: TextFormField(initialValue: email,
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
                                         _email  = value ;
                                        },
                                      )),
                                ],
                              ),
                        )),
                )),
            ScopedModelDescendant<MainModel>(
              builder: (context, child, model) => model.isLoading ?  Container(padding: EdgeInsets.only(top: 20),
                child: Row(mainAxisAlignment:MainAxisAlignment.center,children: [
                  CircularProgressIndicator(),
                  SizedBox(width: 20,),
                  Text("Please Wait....",style: TextStyle(color: Colors.blueAccent),)
                ]),
              ): Container() ),
            SizedBox(height: 50,),
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
                  ScopedModelDescendant<MainModel>(
                      builder: (context, child, model) =>
                          GestureDetector(
                            child: Container(
                                height: 50,
                                color: Theme.of(context).backgroundColor,
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Text(
                                        "Reset my Password",
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
                                    ),
                                  ],
                                )),
                            onTap: () {
                          //    model.forgotPassword(_text.text);
                               _submitForm(model.forgotPassword);
                            },
                          )),
                ],
              ),
            ),
            SizedBox(height: 130,),
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
                            fontSize: 18 ),),
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
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil('/signup',
                      ModalRoute.withName("/signup"));
                },
              ),
            )
          ],
        )
      ],
    )));
  }
}
