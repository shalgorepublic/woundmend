import 'dart:async';

import 'package:derm_pro/scoped_models/main.dart';
import 'package:derm_pro/scoped_models/risk_type_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class SecondRadioGroup extends StatefulWidget {

  @override
  _SecondRadioGroupState createState() => _SecondRadioGroupState();
}

class _SecondRadioGroupState extends State<SecondRadioGroup> {
  String radioItemHolder = 'One';
  int sum = 0;
  int id;
  Widget build(BuildContext context) {
    return
      Container(
          padding: EdgeInsets.only(top: 30 , left: 20 , right: 20) , child:
      Card(
          child: Column(
            children: <Widget>[
              ScopedModelDescendant<MainModel>(
                  builder: (context , child , model) =>
                      Container(
                        padding:
                        EdgeInsets.only(top: 20) ,
                        child: Text(
                          '${model.currentRiskQuestion.question}' ,textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Theme
                                  .of(context)
                                  .accentColor ,
                              fontSize: 16 ,
                              fontWeight: FontWeight.bold) ,
                        ) ,
                      )) ,
              ScopedModelDescendant<MainModel>(
                builder: (context , child , model) =>
                    Container(
                      padding: EdgeInsets.only(
                          top: 25 , left: 25 , right: 25 , bottom: 15) ,
                      child: Text(
                        "Select One features that best matches you${model.riskSelectedFlag}" ,
                        style: TextStyle(
                            fontSize: 13 ,color:model.riskSelectedFlag  ? Colors.red :Colors.blue
                        ) ,
                      ) ,
                    ) ,),
              Container(
                  padding: EdgeInsets.only(left: 25 , right: 25 , bottom: 10) ,
                  child: Container(
                    color: Theme
                        .of(context)
                        .backgroundColor,
                    height: 2 ,
                  )) ,
              ScopedModelDescendant<MainModel>(
                builder: (context , child , model) =>
                    Container(height: MediaQuery
                        .of(context)
                        .size
                        .height / 3.5,
                      child:
                      ListView(
                        children: model.currentRiskQuestion.options
                            .map((data) =>
                            Container(child: Column(children: <Widget>[
                              RadioListTile(activeColor: Theme
                                  .of(context)
                                  .backgroundColor ,
                                dense: true ,
                                title: Text("${data.option}" ,
                                  style: TextStyle(color: Colors.black) ,) ,
                                groupValue: id ,
                                value: data.id ,
                                onChanged: (val) {
                                  setState(() {
                                    radioItemHolder = data.option;
                                    id = data.id;
                                    var index = model.currentRiskQuestion.options.indexOf(data);
                                    if(index == 1) {
                                      sum = sum + index;
                                    }
                                    print(index);
                                  });
                                  model.selectedOptionIdChange(id);
                                  Timer(Duration(milliseconds: 500), () {
                                    if(id != null)
                                    {
                                     //  model.countRiskScore(sum);
                                      model.nextRiskQuestion();
                                      model.countRiskScore(sum);
                                    }
                                  });

                                } ,
                              ) ,
                              Container(
                                padding: EdgeInsets.only(left: 25 , right: 25) ,
                                child:
                                Divider() ,)
                            ] ,) ,)
                        )
                            .toList() ,
                      ) ,
                    ) ,
              ) ,
              SizedBox(height: 10 ,) ,
            ] ,
          )));
  }
}
