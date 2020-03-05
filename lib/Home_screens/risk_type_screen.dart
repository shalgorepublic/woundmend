import 'package:derm_pro/Home_screens/risk_result_screen.dart';
import 'package:derm_pro/Home_screens/setting/ui_elements/no_internet_container.dart';
import 'package:derm_pro/Home_screens/skin_result.dart';
import 'package:derm_pro/Home_screens/ui_elements_home/second_radio.dart';
import 'package:derm_pro/scoped_models/main.dart';
import 'package:derm_pro/scoped_models/risk_type_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../scoped_models/main.dart';

class RiskType extends StatefulWidget {
  final MainModel model;

  RiskType(this.model);

  @override
  _RiskTypeState createState() => _RiskTypeState(model);
}

class _RiskTypeState extends State<RiskType> {
  final model;

  _RiskTypeState(this.model);

  @override
  void initState() {
    model.fetchRiskQuestions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Risk Type"),
          centerTitle: true,
          backgroundColor: Theme.of(context).backgroundColor,
        ),
        body: ListView(
          children: <Widget>[
            ScopedModelDescendant<MainModel>(
                builder: (context, child, model) => model.riskFlag
                    ?
                Column(children: <Widget>[
                  Container( padding: EdgeInsets.only(top: 250),child:
                  CircularProgressIndicator())
                ],)

                    : model.riskNetWorkErrorFlag
                    ? NoInterNet()
                    : Container(
                  child: model.allRiskQuestions.length > 0
                      ? Center(
                      child: Column(
                        children: <Widget>[
                          ScopedModelDescendant<MainModel>(
                              builder: (context, child, model) =>
                                  SecondRadioGroup()),
                          Container(
                            padding: EdgeInsets.only(top: 30),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                GestureDetector(
                                    child: Container(
                                      height: 40,
                                      width: 50,
                                      color:
                                      Theme.of(context).accentColor,
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.arrow_back_ios,
                                          color: Colors.white,
                                        ),
                                        onPressed: () {
                                          if (model
                                              .currentRiskQuestionIndex ==
                                              0) {
                                            Navigator.pop(context);
                                          }
                                          if (model
                                              .currentRiskQuestionIndex <=
                                              model.allRiskQuestions
                                                  .length) {
                                            model.previousRiskQuestion();
                                          }
                                        },
                                      ),
                                    )),
                                ScopedModelDescendant<MainModel>(
                                  builder:
                                      (context, child, model) =>
                                      GestureDetector(
                                        onTap: () {
                                          if (model.currentRiskQuestionIndex ==
                                              0 ||
                                              model.currentRiskQuestionIndex <=
                                                  model.allRiskQuestions
                                                      .length -
                                                      1) {
                                            if (model
                                                .riskSelectedOptionId !=
                                                null) {
                                              model.nextRiskQuestion();
                                            } else {
                                              model
                                                  .riskSelectedFlagTrue();
                                            }
                                          }

                                          if (model.currentRiskQuestionIndex-
                                              1 ==
                                              model.allRiskQuestions
                                                  .length -
                                                  1) {
                                            if (model
                                                .riskSelectedOptionId !=
                                                null) {
                                              Navigator.push<dynamic>(
                                                context,
                                                MaterialPageRoute<
                                                    dynamic>(
                                                  builder: (BuildContext
                                                  context) =>
                                                      RiskResultScreen(model),
                                                ),
                                              );
                                            } else {
                                              model
                                                  .riskSelectedFlagTrue();
                                            }
                                          }
                                        },
                                        child: Container(
                                            height: 40,
                                            color: Theme.of(context)
                                                .backgroundColor,
                                            child: Row(
                                              children: <Widget>[
                                                model.currentRiskQuestionIndex ==
                                                    model.allRiskQuestions
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
                                                          fontWeight:
                                                          FontWeight
                                                              .bold,
                                                          color: Colors
                                                              .white),
                                                    ))
                                                    : Container(),
                                                IconButton(
                                                  icon: Icon(
                                                    Icons
                                                        .arrow_forward_ios,
                                                    color: Colors.white,
                                                  ),
                                                  onPressed: () {},
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
                          )
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
        ));
  }
}
