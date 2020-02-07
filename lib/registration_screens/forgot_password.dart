import 'package:derm_pro/scoped_models/main.dart';
import 'package:derm_pro/ui_elements/app_bar_line.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class ForgotPasswordScreen extends StatelessWidget {
  final _text = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
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
                    child: Container(
                  padding:
                      EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 10),
                  child: TextField(
                    controller: _text,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Email',
                        hintText: 'Enter your email'),
                  ),
                ))),
            ScopedModelDescendant<MainModel>(
              builder: (context, child, model) => model.isLoading ? CircularProgressIndicator(): Container() ),
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
                              model.forgotPassword(_text.text);
                            //  _submitForm(model.authenticate);
                              /* if(_formKey.currentState.validate()) {
                      Navigator.push<dynamic>(
                        context ,
                        MaterialPageRoute<dynamic>(
                          builder: (BuildContext context) => ProfileScreen(),) ,
                      );
                    }*/
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
    ));
  }
}
