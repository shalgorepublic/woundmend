import 'package:derm_pro/Home_screens/Library.dart';
import 'package:derm_pro/Home_screens/edit_profile.dart';
import 'package:derm_pro/Home_screens/promo_code.dart';
import 'package:derm_pro/Home_screens/setting/notification_screen.dart';
<<<<<<< HEAD
import 'package:derm_pro/Home_screens/setting/privacy_policy_web.dart';
=======
>>>>>>> 7ba4d27e4098d46eaf19f3bc2507ac52ace8cebc
import 'package:derm_pro/Home_screens/ui_elements_home/drawer.dart';
import 'package:derm_pro/scoped_models/main.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {

  Future<bool> _onBackPressed(Function logout) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Log out',style: TextStyle(fontWeight:FontWeight.bold),),
            content: Text('Are you sure you want to log out?'),
            actions: <Widget>[
              FlatButton(
                child: Text('NO'),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              FlatButton(
                child: Text('YES'),
                onPressed: () {
                  logout();
                  Navigator.of(context).pop(true);
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      '/myHomePage', (Route<dynamic> route) => false);
                //  Navigator.of(context).pushNamedAndRemoveUntil(
                  //    '/emailPage', ModalRoute.withName("/"));
                },
              ),
            ],
          );
        });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Settings"),
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
                GestureDetector(child:
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(top: 20, left: 20, bottom: 20),
                  child: Container(child: Text("Personal Details")),
                ),onTap: (){
                  Navigator.of(context).push(MaterialPageRoute<dynamic>(
                      builder: (BuildContext context) => EditProfile()));
                },),
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
                GestureDetector(child:
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(top: 20, left: 20, bottom: 20),
                  child: Container(child: Text("FAQ")),
                ),onTap: (){
                  Navigator.pushNamed(context, '/library');
                },),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(top: 20, left: 20, bottom: 20),
                  child: Container(child: Text("Instructions for use")),
                ),
                GestureDetector(child:Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(top: 20, left: 20, bottom: 20),
                  child: Container(child: Text("Add Promo Code")),
                ),onTap: (){
                  Navigator.of(context).push(
                      MaterialPageRoute<dynamic>(
                          builder: (BuildContext context) =>
                              PromoCodeScreen()));
                },),
                GestureDetector(child:
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(top: 20, left: 20, bottom: 20),
                  child: Container(child: Text("Privacy Policy")),
                ),onTap: (){
                  Navigator.of(context).push(
                      MaterialPageRoute<dynamic>(
                          builder: (BuildContext context) =>
                              PrivacyPloicyWebView('https://www.skinvision.com/privacy/')));
                },),
                GestureDetector(child:
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(top: 20, left: 20, bottom: 20),
                  child: Container(child: Text("Terms & Conditions")),
                ),onTap: (){
                  Navigator.of(context).push(
                      MaterialPageRoute<dynamic>(
                          builder: (BuildContext context) =>
                              PrivacyPloicyWebView('https://www.skinvision.com/terms/')));
                },),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(top: 20, left: 20, bottom: 20),
                  child: Container(child: Text("Leave Feebback")),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(top: 10, left: 20, bottom: 20),
                  color: Theme.of(context).hoverColor,
                ),
            ScopedModelDescendant<MainModel>(
              builder: (context, child, model) =>
              GestureDetector(child:
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(top: 20, left: 20, bottom: 20),
                  child: Container(child: Text("Log out")),
                ),onTap: (){
                _onBackPressed(model.logout);

              },),
            )
              ],
            )));
  }
}
