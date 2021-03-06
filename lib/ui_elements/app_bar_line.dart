import 'package:flutter/material.dart';

class AppBarLine extends StatelessWidget {
  double screenWidth;

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    return Container(child: Row(children: <Widget>[
      Container(
        height: 10 ,
        width: screenWidth / 2 ,
        color: Theme.of(context).backgroundColor ,
      ) ,
      Container(
        height: 10 ,
        width: screenWidth / 2 ,
        color: Theme.of(context).accentColor,
      ) ,
    ],),);
  }
}
