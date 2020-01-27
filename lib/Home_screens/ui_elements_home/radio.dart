import 'package:flutter/material.dart';

class RadioGroup extends StatefulWidget {
  @override
  RadioGroupWidget createState() => RadioGroupWidget();
}

class AnswerList {
  String option;
  int index;

  AnswerList({this.option, this.index});
}

class RadioGroupWidget extends State {
  // Default Radio Button Selected Item.
  String radioItemHolder = 'One';

  // Group Value for Radio Button.
  int id = 1;
  String  firstQuestionTitle = 'Your Natural Hair Color is?';
  String  secondQuestionTitle = 'Does your skin Tan?';
  List<AnswerList> nList = [
    AnswerList(
      index: 1,
      option: "Red or Light Brown",
    ),
    AnswerList(
      index: 2,
      option: "Blond",
    ),
    AnswerList(
      index: 3,
      option: "Dark Blond or Light Brown",
    ),
    AnswerList(
      index: 4,
      option: "Dark Brown",
    ),
    AnswerList(
      index: 5,
      option: "Black",
    ),
  ];

  List<AnswerList> secondnList = [
    AnswerList(
      index: 1,
      option: "Naver,I always Burn",
    ),
    AnswerList(
      index: 2,
      option: "Seldom",
    ),
    AnswerList(
      index: 3,
      option: "SomeTimes",
    ),
    AnswerList(
      index: 4,
      option: "Often",
    ),
    AnswerList(
      index: 5,
      option: "Always",
    ),
  ];

  Widget build(BuildContext context) {
    return
        Container(padding:EdgeInsets.only(top: 30,left: 20,right: 20),child:
        Card(
            child: Column(
          children: <Widget>[
            Container(
              padding:
              EdgeInsets.only(top: 20, left: 30, right: 30),
              child: Text(
                '${firstQuestionTitle}',
                style: TextStyle(
                    color: Theme.of(context).accentColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top:25,left: 25, right: 25, bottom: 15),
              child: Text(
                "Select One features that best matches you",
                style: TextStyle(
                  fontSize: 13,
                ),
              ),
            ),
            Container(
                padding: EdgeInsets.only(left: 25, right: 25, bottom: 10),
                child: Container(
                  color: Theme.of(context).backgroundColor,
                  height: 2,
                )),
            Container(height:MediaQuery.of(context).size.height/2.5,
              child:
              ListView(
                children: nList
                    .map((data) => Container(child: Column(children: <Widget>[
                  RadioListTile(activeColor: Theme.of(context).backgroundColor,dense: true,
                    title: Text("${data.option}",style: TextStyle(color: Colors.black),),
                    groupValue: id,
                    value: data.index,
                    onChanged: (val) {
                      setState(() {
                        radioItemHolder = data.option;
                        id = data.index;
                      });
                    },
                  ),
                  Container(padding: EdgeInsets.only(left: 25,right: 25),child:
                  Divider(),)
                ],),)

                )
                    .toList(),
              ),
            ),
          ],
        )));
  }
}
