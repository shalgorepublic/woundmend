import 'package:derm_pro/Home_screens/common/dot.dart';
import 'package:derm_pro/scoped_models/main.dart';
import 'package:derm_pro/ui_elements/dashed_line.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class AlertScreen extends StatelessWidget {
  String firstText = "Skin Cancer early detection is critical for your health. Early detection and treatment can protect from cancer.";
  String secondText = "DermPro assists in early detection by visualising your skin and keep a track of its changes with time. ";
  String thirdText = "DermPro shouldn’t be taken as an alternative to any ongoing medical treatment procedure or medication. ";
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height-200,
//      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 60.0,),
//      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 60.0,),
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Container(
            child: Center(
              //child: Text("helo"),
              child: Image.asset(
                'assets/logo.png',
                width: 200,
                height: 70,
              ),
            ),
          ),
          SizedBox(height: 10,),
          Container(
              child: Column(mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(alignment: Alignment.topLeft,
                  child: Text(
                    "Skin Support",
                    style: TextStyle(
                        color: Theme.of(context).textSelectionColor,
                        fontFamily: 'Bold'),
                  )),
              MyWidget(firstText),
              MyWidget(secondText),
              MyWidget(thirdText),
            ],
          )),
          SizedBox(height: 20,),
    ScopedModelDescendant<MainModel>(
    builder: (BuildContext context, Widget child, MainModel model) {
    return
    Container(
            child: new RaisedButton(
              color: Theme.of(context).accentColor,
              shape: new RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              child: new Text(
                'OK-GOT IT',
                style: TextStyle(
                    fontFamily: 'Bold',
                    fontSize: 18,
                    color: Colors.white),
              ),
              onPressed: () {
                model.alertFlagFalse();
               Navigator.pop(context);
              },
            ),
          );}),
        ],
      ),
    );
  }
}
class MyWidget extends StatelessWidget {
  final word;
  MyWidget(this.word);

  Widget build(BuildContext context) {
    return
    // somewhere down the line
    Container(padding:EdgeInsets.only(top: 30),
      child: Row(mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(padding:EdgeInsets.only(top: 10,left: 10),child:
          CustomPaint(painter: DrawCircle())),
          SizedBox(width: 20,),
          Expanded(child:
          Container(child:
          Text(word))
          )],
      ),
    );
  }
}
