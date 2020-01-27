import 'package:derm_pro/Home_screens/ui_elements_home/radio.dart';
import 'package:flutter/material.dart';

class SkinType extends StatefulWidget {
  @override
  _SkinTypeState createState() => _SkinTypeState();
}

class _SkinTypeState extends State<SkinType> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Skin Type"),
          centerTitle: true,
          backgroundColor: Theme.of(context).backgroundColor,
        ),
        body: ListView(children: <Widget>[
          Center(
              child:Column(children: <Widget>[
                RadioGroup(),

                Container(
                  padding: EdgeInsets.only(top: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      GestureDetector(
                          child: Container(
                            height: 40,
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
                          height: 40,
                          width: 50,
                          color: Theme.of(context).backgroundColor,
                          child: IconButton(
                            icon: Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                            ),
                            onPressed: () {
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 30,)
              ],)

          )
        ],

        )
    );
  }
}
