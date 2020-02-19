import 'package:derm_pro/Home_screens/common/dot.dart';
import 'package:derm_pro/scoped_models/main.dart';
import 'package:derm_pro/ui_elements/dashed_line.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class AlertScreen extends StatelessWidget {
  String firstText = "Skin cancer often is first detected as a skin change keep an eye on changes to your skin.";
  String secondText = "DermPro helps you keep track of skin changes and visualise hard to see areas(such as your back) but does not diagnose skin cancer.";
  String thirdText = "It should not replace any recomded preventive skin checks and medical consultation.";
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: <Widget>[
          Container(
            child: Center(
              //child: Text("helo"),
              child: Image.asset(
                'assets/loupe.jpg',
                width: 80,
                height: 100,
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
          SizedBox(height: 50,),
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
