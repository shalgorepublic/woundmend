import 'package:derm_pro/Home_screens/setting/notification_screen.dart';
import 'package:derm_pro/Home_screens/ui_elements_home/drawer.dart';
import 'package:flutter/material.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Setting"),
        ),
        body: Container(
            color: Colors.white,
            child: ListView(
              children: <Widget>[
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(top: 20, left: 20, bottom: 20),
                  color: Theme.of(context).hoverColor,
                  child: Container(
                      child: Text(
                    "ACCOUNT SETTINGS",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(top: 20, left: 20, bottom: 20),
                  child: Container(child: Text("Personal Details")),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(top: 20, left: 20, bottom: 20),
                  child: Container(child: Text("Subcription")),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(top: 20, left: 20, bottom: 20),
                  color: Theme.of(context).hoverColor,
                  child: Container(
                      child: Text(
                    "NOTIFICATIONS",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
                ),
                GestureDetector(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(top: 20, left: 20, bottom: 20),
                    child: Container(child: Text("Notification Reminders")),
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute<dynamic>(
                        builder: (BuildContext context) =>
                            NotificationScreen()));
                  },
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(top: 20, left: 20, bottom: 20),
                  color: Theme.of(context).hoverColor,
                  child: Container(
                      child: Text(
                    "HELP & SUPPORT",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(top: 20, left: 20, bottom: 20),
                  child: Container(child: Text("FAQ")),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(top: 20, left: 20, bottom: 20),
                  child: Container(child: Text("Instructions for use")),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(top: 20, left: 20, bottom: 20),
                  child: Container(child: Text("Add Promo Code")),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(top: 20, left: 20, bottom: 20),
                  child: Container(child: Text("Privacy Policy")),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(top: 20, left: 20, bottom: 20),
                  child: Container(child: Text("Terms & Conditions")),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(top: 20, left: 20, bottom: 20),
                  child: Container(child: Text("Leave Feebback")),
                ),
              ],
            )));
  }
}
