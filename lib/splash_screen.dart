import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:derm_pro/constants.dart';

class SplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() => new SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  var _visible = true;

  AnimationController animationController;
  Animation<double> animation;

  startTime() async {
    var _duration = new Duration(seconds: 3);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  dispose() {
//    animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
//    animationController = new AnimationController(
//      vsync: this,
//      duration: new Duration(seconds: 2),
//    );
//    animation =
//    new CurvedAnimation(parent: animationController, curve: Curves.easeOut);
//
//    animation.addListener(() => this.setState(() {}));
//    animationController.forward();
//
//    setState(() {
//      _visible = !_visible;
//    });
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child:Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/splash.png'), fit: BoxFit.fill),
        ),
      )),
    );
  }
}
