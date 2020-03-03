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
                      color: Theme.of(context).backgroundColor,
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
                    height: 150,
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
                      color: Theme.of(context).backgroundColor),
                ),
              ),
              Container(
                width: 50,
                height: 2,
                color: Theme.of(context).backgroundColor,
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
              SizedBox(
                height: 1,
              ),
              Container(
                padding: EdgeInsets.only(left: 30, right: 30, top: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Checkbox(
                        value: checkBoxValue,
                        activeColor: Theme.of(context).accentColor,
                        onChanged: (bool newValue) {
                          setState(() {
                            checkBoxValue = newValue;
                          });
                        }),
                    Expanded(
                      child: Container(
                        child: RichText(
                            text: TextSpan(
                          text: "I have read and agree with the ",
                          style: TextStyle(
                              fontSize: 14.0,
                              color: Theme.of(context).highlightColor,fontFamily: 'Reguler'),
                          children: [

                            TextSpan(recognizer:  new TapGestureRecognizer()..onTap = () =>  Navigator.of(context).push(
                                MaterialPageRoute<dynamic>(
                                    builder: (BuildContext context) =>
                                        PrivacyPloicyWebView('https://www.skinvision.com/privacy/'))),
                              text: "Terms & Conditions ",
                              style: TextStyle(
                                fontSize: 14.0,fontFamily: 'Reguler',
                                color: Theme.of(context).backgroundColor,
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
                            TextSpan(recognizer:TapGestureRecognizer()..onTap = () =>  Navigator.of(context).push(
                                MaterialPageRoute<dynamic>(
                                    builder: (BuildContext context) =>
                                        PrivacyPloicyWebView('https://www.skinvision.com/terms/'))),
                              text: "Privicy Policy.",
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Theme.of(context).backgroundColor,
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
                  icon: Icon(
                    Icons.lock_outline,
                    size: 35,
                    color: Theme.of(context).backgroundColor,
                  ),
                )),
              ),
              Container(
                padding: EdgeInsets.only(bottom: 30, left: 30, right: 30),
                child: Text('Your privacy is out most responsibility',
                    style: TextStyle(fontSize: 14.0,
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
                    Navigator.push<dynamic>(
                      context,
                      MaterialPageRoute<dynamic>(
                          builder: (context) => NameScreen()),
                    );
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
                          padding: const EdgeInsets.symmetric(horizontal: 60),
                          child: Text(
                            'LOG IN',
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
