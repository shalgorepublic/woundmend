import 'package:derm_pro/Home_screens/setting/ui_elements/no_internet_container.dart';
import 'package:derm_pro/Home_screens/skin_result.dart';
import 'package:derm_pro/Home_screens/ui_elements_home/radio.dart';
import 'package:derm_pro/scoped_models/main.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:toast/toast.dart';
import '../scoped_models/main.dart';

class SkinType extends StatefulWidget {
  final MainModel model;

  SkinType(this.model);

  @override
  _SkinTypeState createState() => _SkinTypeState(model);
}

class _SkinTypeState extends State<SkinType> {
  final model;

  _SkinTypeState(this.model);

  @override
  void initState() {
    model.fetchQuestions();
    print("flaaaaaaaaaaaaaaaaaaaag");
    print(widget.model.skinSelectedFlag);
    super.initState();
  }

  Future<bool> _onBackPressed() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Are you sure?'),
            content: Text('You cancel the quiz!!'),
            actions: <Widget>[
              FlatButton(
                child: Text('NO'),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              FlatButton(
                child: Text('YES'),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onBackPressed,
        child: Scaffold(
            appBar: AppBar(
              title: Text("Skin Type"),
              centerTitle: true,
              backgroundColor: Theme.of(context).backgroundColor,
            ),
            body: ListView(
              children: <Widget>[
                ScopedModelDescendant<MainModel>(
                    builder: (context, child, model) => model.skinFlag
                        ? Column(
                            children: <Widget>[
                              Container(
                                  padding: EdgeInsets.only(top: 250),
                                  child: CircularProgressIndicator())
                            ],
                          )
                        : model.netWorkErrorFlag
                            ? NoInterNet()
                            : Container(
                                child: model.allQuestions.length > 0
                                    ? Center(
                                        child: Column(
                                        children: <Widget>[
                                          ScopedModelDescendant<MainModel>(
                                              builder:
                                                  (context, child, model) =>
                                                      RadioGroup(widget.model)),
                                          Container(
                                            padding: EdgeInsets.only(top: 30),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                model.currentQuestionIndex == 0
                                                    ? Container()
                                                    : GestureDetector(
                                                        child: Container(
                                                        height: 40,
                                                        width: 50,
                                                        color: Theme.of(context)
                                                            .accentColor,
                                                        child: IconButton(
                                                          icon: Icon(
                                                            Icons
                                                                .arrow_back_ios,
                                                            color: Colors.white,
                                                          ),
                                                          onPressed: () {
                                                            if (model
                                                                    .currentQuestionIndex ==
                                                                0) {
                                                              Navigator.pop(
                                                                  context);
                                                            }
                                                            if (model
                                                                    .currentQuestionIndex <=
                                                                model
                                                                    .allQuestions
                                                                    .length) {
                                                              model
                                                                  .previousQuestion();
                                                            }
                                                          },
                                                        ),
                                                      )),
                                                ScopedModelDescendant<
                                                    MainModel>(
                                                  builder:
                                                      (context, child, model) =>
                                                          GestureDetector(
                                                    onTap: () {
                                                      if (model.currentQuestionIndex ==
                                                              0 ||
                                                          model.currentQuestionIndex <=
                                                              model.allQuestions
                                                                      .length -
                                                                  2) {
                                                        if (model
                                                                .selectedOptionId !=
                                                            null) {
                                                          print("if part");
                                                          model.nextQuestion();
                                                        } else {
                                                          print("helo else");
                                                          model
                                                              .skinSelectedFlagTrue();
                                                        }
                                                      }

                                                      if (model
                                                              .currentQuestionIndex ==
                                                          model.allQuestions
                                                                  .length -
                                                              1) {
                                                        if (model
                                                                .selectedOptionId !=
                                                            null) {
                                                          Navigator.push<
                                                              dynamic>(
                                                            context,
                                                            MaterialPageRoute<
                                                                dynamic>(
                                                              builder: (BuildContext
                                                                      context) =>
                                                                  SkinResultScreen(
                                                                      model),
                                                            ),
                                                          );
                                                        }
                                                        /* else {
                                              model
                                                  .skinSelectedFlagTrue();
                                            }*/
                                                      }
                                                    },
                                                    child: Container(
                                                        height: 40,
                                                        color: Theme.of(context)
                                                            .backgroundColor,
                                                        child: Row(
                                                          children: <Widget>[
                                                            model.currentQuestionIndex ==
                                                                    model.allQuestions
                                                                            .length -
                                                                        1
                                                                ? Container(
                                                                    padding: EdgeInsets
                                                                        .only(
                                                                            left:
                                                                                10),
                                                                    child: Text(
                                                                      "SUBMIT",
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          color:
                                                                              Colors.white),
                                                                    ))
                                                                : Container(),
                                                            IconButton(
                                                              icon: Icon(
                                                                Icons
                                                                    .arrow_forward_ios,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                              onPressed: () {
                                                                model.skinSelectedFlagTrue();
                                                              },
                                                            ),
                                                          ],
                                                        )),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 30,
                                          ),
                                        ],
                                      ))
                                    : Center(
                                        child: Column(
                                        children: <Widget>[
                                          Text("Not Found"),
                                        ],
                                      )),
                              )),
              ],
            )));
  }
}
