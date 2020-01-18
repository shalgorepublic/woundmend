import 'package:derm_pro/registration_screens/name_screen.dart';
import 'package:flutter/material.dart';
import '../ui_elements/dashed_line.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  double screenWidth;
  bool checkBoxValue = false;

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery
        .of(context)
        .size
        .width;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  height: 10 ,
                  width: screenWidth / 2 ,
                  color: Colors.green ,
                ) ,
                Container(
                  height: 10 ,
                  width: screenWidth / 2 ,
                  color: Colors.blue ,
                ) ,
              ] ,
            ) ,
            Container(
              alignment: Alignment.centerLeft ,
              child:IconButton(
                icon: Icon(
                Icons.arrow_back ,
                color: Colors.blue ,
              ) ,
              onPressed: (){
                  Navigator.pop(context);
              },)
            ) ,
            Container(
              padding: EdgeInsets.only( left: 40 , right: 40) ,
              child: Center(
                //child: Text("helo"),
                child: Image.asset(
                  'assets/logo.png' ,
                  width: 300 ,
                  height: 150 ,
                ) ,
              ) ,
            ) ,
            Container(
              padding: EdgeInsets.all(20) ,
              child: Text(
                'Join DERM PRO Today' ,
                style: TextStyle(fontSize: 22 , fontWeight: FontWeight.bold) ,
              ) ,
            ) ,
            Container(
              width: 50 ,
              height: 2 ,
              color: Colors.blue ,
            ) ,
            Container(
              padding:
              EdgeInsets.only(top: 10 , bottom: 20 , left: 30 , right: 30) ,
              child: Text(
                  'We need you to create an account so you can secuerly store your skin risk assessments.' ,
                  textAlign: TextAlign.center) ,
            ) ,
            const MySeparator(color: Colors.blue) ,
            SizedBox(
              height: 1 ,
            ) ,
            Container(
              padding: EdgeInsets.only(left: 30 , right: 30,top: 8) ,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center ,
                children: <Widget>[
                Checkbox(
                value: checkBoxValue ,
                    activeColor: Colors.green,
                    onChanged:(bool newValue){
                      setState(() {
                        checkBoxValue = newValue;
                      });
                  }
              ) ,
              Expanded(child: Container(
              child: RichText(
                  text: TextSpan(
                    text: "I have read and agree with the " ,
                    style: TextStyle(fontSize: 12.0 , color: Colors.black) ,
                    children: <TextSpan>[
                      TextSpan(text: "Terms & Conditions " ,
                        style: TextStyle(fontSize: 12.0 , color: Colors.blue,decoration: TextDecoration.underline,) ,

                      ) ,
                      TextSpan(text: "and " ,
                        style: TextStyle(fontSize: 12.0 , color: Colors.black) ,

                      ) ,
                      TextSpan(text: "Privicy Policy." ,
                        style: TextStyle(fontSize: 12.0 , color: Colors.blue,decoration: TextDecoration.underline,) ,

                      ) ,


                    ] ,
                  )) ,) ,
              ),
          ] ,
        ) ,
      ) ,
      Container(child: Center(child: IconButton(icon: Icon(Icons.lock_outline,size: 35,color: Colors.blue,),)),),
            Container(
              padding:
              EdgeInsets.only(bottom: 20 , left: 30 , right: 30) ,
              child: Text(
                  'We care about your privacy.We are IOS certified for information Security and Medical Device Quality Management.' ,
                  textAlign: TextAlign.center) ,
            ) ,
            Container(
        width: 200.0 ,
        height: 40.0 ,
        child: new RaisedButton(
          color: Colors.blue ,
          shape: new RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5)) ,
          child: new Text(
            'Continue' ,
            style: TextStyle(
                fontWeight: FontWeight.bold ,
                fontSize: 18 ,
                color: Colors.white) ,
          ) ,
          onPressed: () {
            Navigator.push<dynamic>(
              context,
              MaterialPageRoute<dynamic>(
                  builder: (context) => NameScreen()),
            );
          },
        ) ,
      ) ,
            Container(
              margin: EdgeInsets.only(top: 15),
              width: 200.0 ,
              height: 40.0 ,
              child: new RaisedButton(
                color: Colors.blue ,
                shape: new RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)) ,
                child: new Text(
                  'LOGIN' ,
                  style: TextStyle(
                      fontWeight: FontWeight.bold ,
                      fontSize: 18 ,
                      color: Colors.white) ,
                ) ,
                onPressed: () {
                  print("helo");
                } ,
              ) ,
            ) ,
      ] ,
    ),)
    ,
    );
  }
}
