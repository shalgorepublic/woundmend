import 'package:derm_pro/Home_screens/setting/sms_reminders_screen.dart';
import 'package:derm_pro/Home_screens/setting/ui_elements/switch_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}


class _NotificationScreenState extends State<NotificationScreen> {
  bool acceptTerms = false;

  final List<String> _dropdownValues = [
    "Every two weeks",
    "Every month",
    "Every three months",
    "Every half year",
    "Every year"
  ];
  String frequency = 'Every month';
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
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Notifications"),
        ),
        body: Container(
            color: Colors.white,
            child: ListView(
              children: <Widget>[
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(top: 15, left: 20, bottom: 15),
                  color: Theme.of(context).hoverColor,
                  child: Container(
                      child: Text(
                    "REMINDERS",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 20, bottom: 10),
                  child: Container(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('Frequency'),
                      Container(padding:EdgeInsets.only(right: 30),child:
                      DropdownButtonHideUnderline(
                        child:
                      DropdownButton(
                        items: _dropdownValues
                            .map((value) => DropdownMenuItem(
                          child: Text(value),
                          value: value,
                        ))
                            .toList(),
                        onChanged: (String value) {
                          setState(() {
                            frequency = value;
                          });
                        },
                        isExpanded: false,
                        hint: Text(frequency),
                      )),
                      /*GestureDetector(
                        child: Text("Every Month",style: TextStyle(color: Theme.of(context).accentColor),),
                        onTap: () {},
                      )*/
                      )
                    ],
                  )),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only( left: 20, bottom: 10),
                  child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('Add to Calendar'),
                          Container(padding:EdgeInsets.only(right: 30),child:
                          GestureDetector(
                            child: Icon(Icons.add,color: Theme.of(context).accentColor,size: 25,),
                            onTap: () {},
                          ))
                        ],
                      )),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(top: 15, left: 20, bottom: 15),
                  color: Theme.of(context).hoverColor,
                  child: Container(
                      child: Text(
                    "NOTIFICATION CHANNELS",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
                ),
                SwitchButton(),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only( left: 20, bottom: 20),
                  child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('Phone Number'),
                          Container(padding:EdgeInsets.only(right: 30),child:
                          GestureDetector(
                            child: Text("Add Number",style: TextStyle(color: Theme.of(context).accentColor),),
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute<dynamic>(
                                  builder: (BuildContext context) =>
                                      SmsReminderScreen()));
                            },
                          ))
                        ],
                      )),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  color: Theme.of(context).hoverColor,
                  padding: EdgeInsets.only(top: 15, left: 20, bottom: 15),
                  child: Container(
                      child: Text(
                    "Add and verify your number to receive SMS notification",
                    style: TextStyle(fontSize: 13),
                  )),
                ),
              ],
            )));
  }
}

