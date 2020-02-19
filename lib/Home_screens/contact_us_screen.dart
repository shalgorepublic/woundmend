import 'package:derm_pro/ui_elements/app_bar_line.dart';
import 'package:derm_pro/ui_elements/dashed_line.dart';
import 'package:flutter/material.dart';

class ContactUsScreen extends StatelessWidget {
  String firstText =
      'We would love to hear your feedback on the app.Please remember that DermPro Does not provide you with any assessment on the photos you take with the app.Thank You!';

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
                Container(
                  width: 220.0,
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
                      /* Navigator.push<dynamic>(
              context,
              MaterialPageRoute<dynamic>(
                  builder: (context) => NameScreen()),
            );*/
                    },
                  ),
                ),
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
                Container(
                  margin: EdgeInsets.only(bottom: 30),
                  width: 220,
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
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              'SEE ARTICLES',
                              style: TextStyle(
                                  fontFamily: 'Bold', fontSize: 32),
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
                     /* Navigator.of(context).pushNamedAndRemoveUntil(
                          '/emailPage', ModalRoute.withName("/signup"));*/
                    },
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
