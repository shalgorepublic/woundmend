import 'package:derm_pro/scoped_models/main.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class RiskResultScreen extends StatefulWidget {
  final MainModel model;

  RiskResultScreen(this.model);

  @override
  _RiskResultScreenState createState() => _RiskResultScreenState();
}

class _RiskResultScreenState extends State<RiskResultScreen> {
  Map<String, dynamic> firstType = {
    'type': 'Low Risk',
    'description':
        'You have not answered any questions with yes.This means you do not have the characteristics of someone with a risk profile to develope melanoma, however you can never be sure you will not develope melanoma.'
  };
  Map<String, dynamic> secondType = {
    'type': 'High Risk',
    'description':
        'The questions are aimed to find out whether you have a risk profile to develope melanoma.You have answered one or multiple questions with yes.This means you are one of many who are at risk of developing a melanoma.'
  };
  Map<String, dynamic> finalResult;

  @override
  void initState() {
    if (widget.model.totalRiskScore >= 0 && widget.model.totalRiskScore <= 3) {
      setState(() {
        finalResult = firstType;
      });
    }
    else
      {
        setState(() {
          finalResult = secondType;
        });
      }
    widget.model.finalRiskResult(
        finalResult['type'], finalResult['description'], widget.model.user.id,widget.model.skinType);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Risk Type"),
        ),
        body: Column(children: [
          Expanded(
              child: ListView(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 50, left: 150, right: 150),
                child: Column(
                  children: <Widget>[
                    Container(
                        decoration: new BoxDecoration(
                            color: Colors.brown,
                            borderRadius:
                                new BorderRadius.all(Radius.circular(10))),
                        padding: EdgeInsets.only(top: 30, bottom: 30)),
                  ],
                ),
              ),
              ScopedModelDescendant<MainModel>(
                  builder: (context, child, model) => Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(
                          top: 20,
                        ),
                        child: Text(
                          model.riskType,
                          style: TextStyle(fontSize: 22, color: Colors.black54),
                        ),
                      )),
              ScopedModelDescendant<MainModel>(
                builder: (context, child, model) => Container(
                  padding: EdgeInsets.only(left: 20, right: 20, top: 30),
                  child: Text(
                    model.riskDescriptions,
                    style: TextStyle(color: Colors.black54, fontSize: 18),
                  ),
                ),
              ),
            ],
          )),
          Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top: 20, bottom: 20),
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      width: 220.0,
                      height: 40.0,
                      child: new RaisedButton(
                        color: Theme.of(context).backgroundColor,
                        shape: new RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        child: new Text(
                          'DONE',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.white),
                        ),
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, '/profilePage');
                        },
                      ),
                    ),
                  ),
                  GestureDetector(
                    child: Container(
                      padding: EdgeInsets.only(bottom: 20),
                      alignment: Alignment.center,
                      child: Text(
                        "Retake",
                        style: TextStyle(
                            fontSize: 18,
                            color: Theme.of(context).backgroundColor),
                      ),
                    ),
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/riskPage');
                    },
                  )
                ],
              ))
        ]));
  }
}
