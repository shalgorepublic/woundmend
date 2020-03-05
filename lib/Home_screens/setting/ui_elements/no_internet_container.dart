import 'package:flutter/material.dart';

class NoInterNet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Container(
        padding: EdgeInsets.only(top: 150),
        child: AlertDialog(
          title: Text('En Error Occured'),
          content: Text("No internet connection"),
          actions: <Widget>[
            FlatButton(
              child: Text('Okey'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        )
    );
  }
}
