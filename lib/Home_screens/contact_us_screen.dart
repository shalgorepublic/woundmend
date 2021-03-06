import 'package:derm_pro/Home_screens/Library.dart';
import 'package:derm_pro/Home_screens/support.dart';
import 'package:derm_pro/scoped_models/main.dart';
import 'package:derm_pro/ui_elements/app_bar_line.dart';
import 'package:derm_pro/ui_elements/dashed_line.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class ContactUsScreen extends StatelessWidget {
  String firstText =
      'Please contact us in case of any technical support required. DermPro provides basic assessment on the photos you take with the app, Professional advice will be only provided by your DermPro Doctor.';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                AppBarLine(),
                Container(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: Theme.of(context).backgroundColor,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    )),
                Container(
                  padding: EdgeInsets.only(left: 40, right: 40),
                  child: Center(
                    //child: Text("helo"),
                    child: Image.asset(
                      'assets/chat.jpg',
                      width: 100,
                      height: 100,
                    ),
                  ),
                ),
                SizedBox(height: 30,),
                Container(
                  child: Text(
                    'Skin Support',
                    style: TextStyle(
                        fontSize: 22,
                        fontFamily: 'Bold',
                        color: Theme.of(context).textSelectionColor),
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.only(top: 20, bottom: 30, left: 35, right: 35),
                  child: Text(
                  firstText,
                    style: TextStyle(
                        fontFamily: 'Reguler',
                        color: Theme.of(context).highlightColor),
                    textAlign: TextAlign.center,
                  ),
                ),
        ScopedModelDescendant<MainModel>(
          builder: (context , child , model) =>
                Container(
                  width:MediaQuery.of(context).size.width/1.5,
                  height: 40.0,
                  child: new RaisedButton(
                    color: Theme.of(context).backgroundColor,
                    shape: new RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    child: new Text(
                      'CONTACT SUPPORT',
                      style: TextStyle(
                          fontFamily: 'Bold',
                          fontSize: 18,
                          color: Colors.white),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute<dynamic>(
                              builder: (BuildContext context) =>
                                  SupportScreen(model)));
                    },
                  ),
                )),
                SizedBox(
                  height: 40,
                ),
                const MySeparator(),
                SizedBox(height: 30,),
                Container(
                  child: Text(
                    'Skin Check Questions', 
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Bold',
                        color: Theme.of(context).textSelectionColor),
                  ),
                ),
                Container(padding: EdgeInsets.only(left: 35,right: 35,top: 10,bottom: 10),
                  child: Text(
                    'Want to become Smarter about checking your skin?',textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Reguler',
                        color: Theme.of(context).highlightColor),
                  ),
                ),
                GestureDetector(child:
                Container(
                  margin: EdgeInsets.only(bottom: 30),
                  width:MediaQuery.of(context).size.width/1.5,
                  height: 40,
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
                            style: TextStyle(fontSize: 18),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Text(
                              'FAQ',
                              style: TextStyle(
                                  fontFamily: 'Bold', fontSize: 18),
                            ),
                          ),
                          Text(
                            '- - - - - - -',
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                    textColor: Colors.white,
                    onPressed: () {
                      Navigator.pushNamed(context, '/library');
                    },
                  ),
                ),onTap: (){

                },)
              ],
            )
          ],
        ),
      ),
    );
  }
}
