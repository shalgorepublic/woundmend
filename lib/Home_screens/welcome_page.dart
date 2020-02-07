import 'package:derm_pro/ui_elements/app_bar_line.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: <Widget>[
          AppBarLine(),
          Container(
            padding: EdgeInsets.only(top: 50, left: 70, right: 70),
            alignment: Alignment.center,
            child: Container(
              padding: EdgeInsets.only(left: 40, right: 40),
              child: Text(
                "Welcome to DermPro!",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Theme.of(context).backgroundColor,
                    fontSize: 26,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Container(
              child: Expanded(
            child: Padding(
                padding: EdgeInsets.only(left: 15, right: 15),
                child: ListView(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Container(
                          child: Row(
                            children: <Widget>[
                              Container(
                                child: Image.asset(
                                  'assets/polaroids.png',
                                  width: 80,
                                  height: 100,
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.only(top: 30),
                                        child: Text(
                                          "Use our 'Smart check' to get an instant risk indication on your skin spot.",
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 16),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(top: 10),
                                        alignment: Alignment.topLeft,
                                        child: Text("Rs1200.00 single check"),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(top: 10),
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                            "3 months of unlimited checks for Rs4200.00"),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(top: 10),
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                            "1 year of unlimited checks for Rs8500.00"),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          child: Row(
                            children: <Widget>[
                              Container(
                                child: Image.asset(
                                  'assets/scan.png',
                                  width: 80,
                                  height: 100,
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.only(top: 30),
                                        child: Text(
                                          "Save photos of skin spots so you can look for changes over time ",
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 16),
                                        ),
                                      ),
                                      Container(padding:EdgeInsets.only(left: 20,top: 10),child:
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            child: Image.asset(
                                              'assets/checked.png',
                                              color:
                                                  Theme.of(context).accentColor,
                                              width: 100,
                                              height: 100,
                                            ),
                                          ),
                                          Container(
                                            padding:
                                                EdgeInsets.only(bottom: 80,left: 10),
                                            child: Text(
                                              "Free",
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .accentColor,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )
                                        ],
                                      ))
                                    ],
                                  ),
                                ),
                              ),

                            ],
                          ),
                        ),
                        Container(
                          child: Row(
                            children: <Widget>[
                              Container(
                                child: Image.asset(
                                  'assets/clipboard.png',
                                  width: 80,
                                  height: 100,
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Column(
                                    children: <Widget>[
                                      Container(alignment:Alignment.topLeft,
                                        padding: EdgeInsets.only(top: 30),
                                        child: Text(
                                          "Set skin check reminders",
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 16),
                                        ),
                                      ),
                                      Container(padding:EdgeInsets.only(left: 20,top: 10),child:
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            child: Image.asset(
                                              'assets/checked.png',
                                              color:
                                              Theme.of(context).accentColor,
                                              width: 100,
                                              height: 100,
                                            ),
                                          ),
                                          Container(
                                            padding:
                                            EdgeInsets.only(bottom: 80,left: 10),
                                            child: Text(
                                              "Free",
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .accentColor,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )
                                        ],
                                      ))
                                    ],
                                  ),
                                ),
                              ),

                            ],
                          ),
                        ),
                        Container(
                          child: Row(
                            children: <Widget>[
                              Container(
                                child: Image.asset(
                                  'assets/sun.png',
                                  width: 80,
                                  height: 100,
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.only(top: 30),
                                        child: Text(
                                          "Get local UV updates with our UV index",
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 16),
                                        ),
                                      ),
                                      Container(padding:EdgeInsets.only(left: 20,top: 10),child:
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            child: Image.asset(
                                              'assets/checked.png',
                                              color:
                                              Theme.of(context).accentColor,
                                              width: 100,
                                              height: 100,
                                            ),
                                          ),
                                          Container(
                                            padding:
                                            EdgeInsets.only(bottom: 80,left: 10),
                                            child: Text(
                                              "Free",
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .accentColor,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )
                                        ],
                                      ))
                                    ],
                                  ),
                                ),
                              ),

                            ],
                          ),
                        ),
                        Container(
                          child: Row(
                            children: <Widget>[
                              Container(
                                child: Image.asset(
                                  'assets/letter.png',
                                  width: 80,
                                  height: 100,
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.only(top: 30),
                                        child: Text(
                                          "Access your risk profile and skin type",
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 16),
                                        ),
                                      ),
                                      Container(padding:EdgeInsets.only(left: 20,top: 10),child:
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            child: Image.asset(
                                              'assets/checked.png',
                                              color:
                                              Theme.of(context).accentColor,
                                              width: 100,
                                              height: 100,
                                            ),
                                          ),
                                          Container(
                                            padding:
                                            EdgeInsets.only(bottom: 80,left: 10),
                                            child: Text(
                                              "Free",
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .accentColor,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )
                                        ],
                                      ))
                                    ],
                                  ),
                                ),
                              ),

                            ],
                          ),
                        )
                      ],
                    )
                  ],
                )),
          )),
          SizedBox(
              width: MediaQuery.of(context).size.width / 1.30,
              child: RaisedButton(
                color: Theme.of(context).backgroundColor,
                child: Text(
                  "CONTINUUE",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/profilePage');
                },
              )),
          SizedBox(
            height: 10,
          )
        ],
      )),
    );
  }
}
