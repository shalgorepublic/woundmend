import 'package:derm_pro/Home_screens/ui_elements_home/drawer.dart';
import 'package:flutter/material.dart';

class InboxScreen extends StatefulWidget {
  @override
  _InboxScreenState createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  @override
  Widget build(BuildContext context) {
    return
      WillPopScope(
        onWillPop: (){
          Navigator.pop(context);
          Navigator.pushReplacementNamed(context, '/profilePage');
        },
        child:
      Scaffold(
      appBar: AppBar(title:Text( "Inbox")),
        drawer: DrawerBuilder(),
        body:
      Container()));
  }
}