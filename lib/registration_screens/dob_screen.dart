import 'package:derm_pro/registration_screens/email_page.dart';
import 'package:flutter/material.dart';
import '../registration_screens/phone_number_screen.dart';

class DobScreen extends StatefulWidget {
  @override
  _DobScreen createState() => _DobScreen();
}

class _DobScreen extends State<DobScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: <Widget>[
        Column(children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 40, right: 40, top: 30),
            child: Center(
              //child: Text("helo"),
              child: Image.asset(
                'assets/logo.png',
                width: 300,
                height: 150,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            decoration: new BoxDecoration(
              //new Color.fromRGBO(255, 0, 0, 0.0),
              borderRadius: new BorderRadius.all(Radius.circular(50)),
            ),
            child: Card(
                child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 20, bottom: 10),
                  child: Text(
                    "WHAT IS YOUR DATE OF BIRTH",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).backgroundColor),
                  ),
                ),
                Container(
                  width: 50,
                  height: 2,
                  color: Theme.of(context).backgroundColor,
                ),
                Container(
                    margin: const EdgeInsets.only(right: 10, left: 10),
                    padding: EdgeInsets.only(bottom: 20, top: 20),
                    child: Column(
                      children: <Widget>[
                        TextField(onTap: (){
                          print("calender open");
                        },
                          textAlignVertical: TextAlignVertical.center,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue)),
                              labelText: '01 January 2020',
                              labelStyle: TextStyle(fontSize: 18),
                              filled: true,
                              fillColor: Colors.white),
                          keyboardType: TextInputType.number,
                        ),
                        Container(padding:EdgeInsets.only(top: 3),child:
                        Row(
                          children: <Widget>[
                            Text(
                              "You must be over the age of 16 to use",
                              style: TextStyle(
                                  color: Theme.of(context).backgroundColor),
                            ),
                            Text("DERM PRO",style: TextStyle(color: Theme.of(context).accentColor),)
                          ],
                        )),
                      ],
                    )),
              ],
            )),
          ),
          Container(
            padding: EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                GestureDetector(
                    child: Container(
                  height: 50,
                  width: 50,
                  color: Theme.of(context).accentColor,
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                )),
                GestureDetector(
                  child: Container(
                      height: 50,
                      width: 50,
                      color: Theme.of(context).backgroundColor,
                      child:
                          IconButton(
                            icon: Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                            ),
                          ),


                      ),
                    onTap: () {
                      Navigator.push<dynamic>(
                        context,
                        MaterialPageRoute<dynamic>(
                            builder: (context) => PhoneScreen()),
                      );
                    }

                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 30),
            child: SizedBox(
              width: 220.0,
              height: 40.0,
              child: new RaisedButton(
                color: Theme.of(context).accentColor,
                shape: new RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                child: Text(
                  'LOGIN',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.white),
                ),
                onPressed: () {
                  Navigator.push<dynamic>(
                    context,
                    MaterialPageRoute<dynamic>(
                        builder: (context) => EmailPage()),
                  );
                }

                /* onPressed: () {
                      Navigator.push<dynamic>(
                        context,
                        MaterialPageRoute<dynamic>(
                            builder: (context) => SignupScreen()),
                      );
                    },*/
              ),
            ),
          ),
        ])
      ],
    ));
  }
}
