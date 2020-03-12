import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class SwitchButton extends StatefulWidget {
  @override
  _SwitchButtonState createState() => _SwitchButtonState();
}

class _SwitchButtonState extends State<SwitchButton> {

  bool acceptTerms = false;
  Widget _buildAcceptSwitch() {
    return Transform.scale( scale: 0.7,
        child: CupertinoSwitch(
          activeColor: Theme.of(context).accentColor,
          value: acceptTerms,
          onChanged: (bool value) {
            setState(() {
              acceptTerms = value;
            });
          },
        ));
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(right:20, left: 20, bottom: 15),
      child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[Flexible(child:
            Text('Get SMS'),),Flexible(child:
            Container(child:
            _buildAcceptSwitch()
            ))
            ],
          )),
    ) ;
  }
}

