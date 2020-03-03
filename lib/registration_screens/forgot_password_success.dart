import 'package:derm_pro/registration_screens/email_page.dart';
import 'package:derm_pro/ui_elements/app_bar_line.dart';
import 'package:flutter/material.dart';

class ForgotPasswordSuccessScreen extends StatelessWidget {
  final email;

  ForgotPasswordSuccessScreen(this.email);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            AppBarLine(),
            Container(
              padding: EdgeInsets.only(left: 40, right: 40, top: 60),
              child: Center(
                //child: Text("helo"),
                child: Image.asset(
                  'assets/gmail.png',
                  width: 300,
                  height: 150,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 20,left: 20,right: 20),
              alignment: Alignment.center,
              child: Text(
                "We have	sent	you	an	email	to	verify	your	account.",
                style: TextStyle(fontSize: 24, color: Colors.grey),textAlign: TextAlign.center,
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 30, right: 30),
              child: Text(
                "Please	check	your	inbox	and	follow	the	provided	directions	in	the	emailto	complete	the	verification	process.",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 50, right: 50, top: 30),
              child: SizedBox(
                  child: RaisedButton(
                    elevation: 4,
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    color: Theme.of(context).accentColor,
                    child: Text(
                      "Done",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamedAndRemoveUntil('/emailPage',
                          ModalRoute.withName("/emailPage"));
                    },
                  )),
            ),
            GestureDetector(child:
            Container(padding:EdgeInsets.only(top: 20),
              alignment: Alignment.center,
              child: Text(
                "Did	not	receive	email?	Click	to	resen",
                style: TextStyle(
                    fontSize: 14, color: Theme.of(context).backgroundColor),
              ),
            ),
            onTap: (){

            },),
            Container(padding: EdgeInsets.only(left: 50,right: 50,top: 20),
              child: RaisedButton(
                elevation: 4,
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                color: Theme.of(context).accentColor,
                child: FittedBox(
                  child: Row(
                    children: <Widget>[
                      Text(
                        '- - - - - - -',
                        style: TextStyle(fontSize: 12),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 60),
                        child: Text('SIGNUP',style: TextStyle( fontWeight: FontWeight.bold ,
                            fontSize: 18 ),),
                      ),
                      Text(
                        '- - - - - - -',
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),
                textColor: Colors.white,
                onPressed: () {
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil('/signup',
                      ModalRoute.withName("/signup"));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
