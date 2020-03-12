import 'dart:async';

import 'package:derm_pro/Home_screens/skin_result.dart';
import 'package:derm_pro/scoped_models/main.dart';
import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class RadioGroup extends StatefulWidget {
  @override
  _RadioGroupState createState() => _RadioGroupState();
}

class _RadioGroupState extends State<RadioGroup> {
  String radioItemHolder = 'One';
  int sum = 0;
  int id;
  ScrollController _rrectController = ScrollController();

  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: 30, left: 20, right: 20),
        child: Card(
            child: Column(
          children: <Widget>[
            ScopedModelDescendant<MainModel>(
                builder: (context, child, model) => Container(
                      padding: EdgeInsets.only(top: 20),
                      child: Text(
                        '${model.currentQuestion.question}',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Theme.of(context).accentColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    )),
            ScopedModelDescendant<MainModel>(
              builder: (context, child, model) => Container(
                padding:
                    EdgeInsets.only(top: 25, left: 25, right: 25, bottom: 15),
                child: Text(
                  "Select One features that best matches you${model.skinSelectedFlag}",
                  style: TextStyle(
                      fontSize: 13,
                      color: model.skinSelectedFlag ? Colors.red : Colors.blue),
                ),
              ),
            ),
            Container(
                padding: EdgeInsets.only(left: 25, right: 25, bottom: 10),
                child: Container(
                  color: Theme.of(context).backgroundColor,
                  height: 2,
                )),
            ScopedModelDescendant<MainModel>(
              builder: (context, child, model) => Container(
                height: MediaQuery.of(context).size.height / 2.5,
                child: DraggableScrollbar.rrect(
                  alwaysVisibleScrollThumb: true,
                  backgroundColor: Theme.of(context).backgroundColor,
                  controller: _rrectController,
                  child: ListView(
                    controller: _rrectController,
                    children: model.currentQuestion.options
                        .map((data) => Container(
                              child: Column(
                                children: <Widget>[
                                  RadioListTile(
                                    activeColor:
                                        Theme.of(context).backgroundColor,
                                    dense: true,
                                    title: Text(
                                      "${data.option}",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    groupValue: id,
                                    value: data.id,
                                    onChanged: (val) {
                                      setState(() {
                                        radioItemHolder = data.option;
                                        id = data.id;
                                        var index = model
                                            .currentQuestion.options
                                            .indexOf(data);
                                        sum = sum + index;
                                        print(sum);
                                      });
                                      model.selectedOptionIdChange(id);
                                      Timer(Duration(milliseconds: 500), () {
                                        if (id != null) {
                                          // model.countScore(sum);
                                          if (model.allQuestions.length - 1 ==
                                              model.currentQuestionIndex) {
                                            Navigator.push<dynamic>(
                                              context,
                                              MaterialPageRoute<dynamic>(
                                                builder:
                                                    (BuildContext context) =>
                                                        SkinResultScreen(model),
                                              ),
                                            );
                                          } else
                                            model.nextQuestion();
                                          model.countScore(sum);
                                        }
                                      });
                                    },
                                  ),
                                  Container(
                                    padding:
                                        EdgeInsets.only(left: 25, right: 25),
                                    child: Divider(),
                                  )
                                ],
                              ),
                            ))
                        .toList(),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        )));
  }
}
