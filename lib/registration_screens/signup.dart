import 'package:derm_pro/Home_screens/setting/privacy_policy_web.dart';
import 'package:derm_pro/registration_screens/name_screen.dart';
import 'package:derm_pro/ui_elements/app_bar_line.dart';
import 'package:flutter/material.dart';
import '../ui_elements/dashed_line.dart';
import 'package:flutter/gestures.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  double screenWidth;
  bool checkBoxValue = false;
  bool value = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              AppBarLine(),
              Container(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: Theme.of(context).accentColor,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )),
              Container(
                padding: EdgeInsets.only(left: 40, right: 40),
                child: Center(
                  //child: Text("helo"),
                  child: Image.asset(
                    'assets/logo.png',
                    width: 300,
                    height: 80,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(20),
                child: Text(
                  'Join DERM PRO',
                  style: TextStyle(
                      fontSize: 22,
                      fontFamily: 'Bold',
                      color: Theme.of(context).accentColor),
                ),
              ),
              Container(
                width: 50,
                height: 2,
                color: Theme.of(context).accentColor,
              ),
              Container(
                padding:
                    EdgeInsets.only(top: 10, bottom: 20, left: 30, right: 30),
                child: Text(
                  'Account registration is required to store your skin risk assessment and to provide feedback',
                  style: TextStyle(
                      fontFamily: 'Reguler',
                      color: Theme.of(context).textSelectionColor),
                  textAlign: TextAlign.center,
                ),
              ),
              const MySeparator(),
              value ?
              Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,children: <Widget>[
                Container(margin: EdgeInsets.only(left: 45,top: 10),
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "Check to continue",
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Theme.of(context).accentColor,
                ),
                Container(),
              ],):Container(),

              Container(
                padding: EdgeInsets.only(
                  left: 30,
                  right: 30,
                  top: 10
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Checkbox(
                        value: checkBoxValue,
                        activeColor: Theme.of(context).accentColor,
                        onChanged: (bool newValue) {
                          setState(() {
                            checkBoxValue = newValue;
                            if(value == true){
                              value = false;
                            }
                          });
                        }),
                    Expanded(
                      child: Container(
                        child: RichText(
                            text: TextSpan(
                          text: "I have read and agree with the ",
                          style: TextStyle(
                              fontSize: 14.0,
                              color: Theme.of(context).highlightColor,
                              fontFamily: 'Reguler'),
                          children: [
                            TextSpan(
                              recognizer: new TapGestureRecognizer()
                                ..onTap = () => Navigator.of(context).push(
                                    MaterialPageRoute<dynamic>(
                                        builder: (BuildContext context) =>
                                            PrivacyPloicyWebView(
                                                'https://www.skinvision.com/privacy/'))),
                              text: "Terms & Conditions ",
                              style: TextStyle(
                                fontSize: 14.0,
                                fontFamily: 'Reguler',
                                color: Theme.of(context).accentColor,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            TextSpan(
                              text: "and ",
                              style: TextStyle(
                                  fontSize: 14.0,
                                  fontFamily: 'Reguler',
                                  color: Theme.of(context).highlightColor),
                            ),
                            TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => Navigator.of(context).push(
                                    MaterialPageRoute<dynamic>(
                                        builder: (BuildContext context) =>
                                            PrivacyPloicyWebView(
                                                'https://www.skinvision.com/terms/'))),
                              text: "Privicy Policy.",
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Theme.of(context).accentColor,
                                fontFamily: 'Reguler',
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ],
                        )),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Center(
                    child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.lock_outline,
                    size: 35,
                    color: Theme.of(context).backgroundColor,
                  ),
                )),
              ),
              Container(
                padding: EdgeInsets.only(bottom: 30, left: 30, right: 30),
                child: Text('Your privacy is our most responsibility',
                    style: TextStyle(
                        fontSize: 14.0,
                        color: Theme.of(context).highlightColor,
                        fontFamily: 'Reguler'),
                    textAlign: TextAlign.center),
              ),
              Container(
                width: 220.0,
                height: 40.0,
                child: new RaisedButton(
                  color: Theme.of(context).backgroundColor,
                  shape: new RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  child: new Text(
                    'CONTINUE',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white),
                  ),
                  onPressed: () {
                    if(checkBoxValue == true) {
                      setState(() {
                        value = false;
                      });
                      Navigator.push<dynamic>(
                        context ,
                        MaterialPageRoute<dynamic>(
                            builder: (context) => NameScreen()) ,
                      );
                    }
                    else
                      setState(() {
                        value = true;
                      });
                  },
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                margin: EdgeInsets.only(bottom: 30),
                width: 220,
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
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: Text(
                            'LOGIN',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
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
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        '/emailPage', ModalRoute.withName("/signup"));
                  },
                ),
              )
            ],
          ),
        ],
      )),
    );
  }
}
