import 'dart:io';
import 'package:derm_pro/Home_screens/Library.dart';
import 'package:derm_pro/Home_screens/edit_profile.dart';
import 'package:derm_pro/Home_screens/skin_result.dart';
import 'package:derm_pro/Home_screens/ui_elements_home/drawer.dart';
import 'package:derm_pro/Home_screens/weather/weatherPage.dart';
import 'package:derm_pro/scoped_models/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scoped_model/scoped_model.dart';

class ProfileScreen extends StatefulWidget {
  final model;

  ProfileScreen(this.model);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File _image;
  File imageSource;
  bool imagePickerflag = false;

  @override
  void initState() {
    // TODO: implement initState
    widget.model.fetchQuestions();
    super.initState();
  }

  Future imagepicker() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;
    });
  }

  Future<bool> _onBackPressed() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Are you sure?'),
            content: Text('You are going to exit the application!!'),
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
                  SystemNavigator.pop();
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
          body: Container(
            color: Colors.white,
            // length: 0,
            child: NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    SliverAppBar(
                      backgroundColor: Theme.of(context).backgroundColor,
                      floating: false,
                      pinned: true,
                      flexibleSpace: ScopedModelDescendant<MainModel>(
                          builder: (context, child, model) => FlexibleSpaceBar(
                                centerTitle: true,
                                title: Text(
                                  '${model.user.firstName} ${model.user.lastName}',
                                  style: TextStyle(fontSize: 22),
                                ),
                              )),
                    ),
                    new SliverPadding(
                      padding: new EdgeInsets.all(0.0),
                      sliver: new SliverList(
                        delegate: new SliverChildListDelegate([
                          PreferredSize(
                              preferredSize: const Size.fromHeight(160.0),
                              child: Container(
                                child: Theme(
                                  data: Theme.of(context)
                                      .copyWith(accentColor: Colors.blue),
                                  child: ContainerWithCircle(),
                                ),
                              ))
                        ]),
                      ),
                    ),
                  ];
                },
                body: ListView(
                  children: <Widget>[
                    Container(
                      color: Colors.white,
                      padding: EdgeInsets.only(top: 20, left: 25, right: 25),
                      child: Column(
                        children: <Widget>[
                          Text(
                            "Welcome to your Profile Page",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 30),
                            child: Text(
                              "At the top you will find personal information about at you skin type,risk profile and local UV index.",
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Container(
                            child: Icon(
                              Icons.camera_alt,
                              size: 150,
                              color: Colors.grey,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(bottom: 80, top: 20),
                            child: Text(
                                "Your skin checks will be stored in the here."),
                          )
                        ],
                      ),
                    ),
                  ],
                )),
          ),
          drawer: DrawerBuilder(),
          floatingActionButton: Padding(
            padding: EdgeInsets.only(top: 30),
            child: SizedBox(
              height: 60,
              width: 60,
              child: FloatingActionButton(
                backgroundColor: Colors.blue,
                elevation: 0,
                onPressed: () {
                  imagepicker();
                },
                child: Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white,
                        width: 5,
                      ),
                      shape: BoxShape.circle,
                      color: Theme.of(context).accentColor),
                  child: Icon(
                    Icons.camera_alt,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: BottomAppBar(
            color: Colors.white,
            child: Container(
              height: 60,
              color: Theme.of(context).backgroundColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 50, top: 10),
                    child: Column(
                      children: <Widget>[
                        Icon(
                          Icons.mail,
                          color: Colors.white,
                        ),
                        Container(
                          child: Text(
                            "Inbox",
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.only(right: 50,top: 10),
                      child: Column(
                        children: <Widget>[
                          Icon(
                            Icons.feedback,
                            color: Colors.white,
                          ),
                          Container(
                            child: Text(
                              "Support",
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        ],
                      )),
                ],
              ),
            ),
          ),
        ));
  }
}

class ContainerWithCircle extends StatefulWidget {
  @override
  _ContainerWithCircleState createState() => _ContainerWithCircleState();
}

class _ContainerWithCircleState extends State<ContainerWithCircle> {
  bool flagone = false;
  bool flagtwo = false;
  bool flagthree = false;
  final double circleRadius = 80.0;
  final double circleBorderWidth = 3.0;
  String skinPage;
  String riskPage;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
            decoration: BoxDecoration(
              color: Colors.white,
              //    color: Theme.of(context).backgroundColor,
              border: Border.all(
                color: Theme.of(context)
                    .backgroundColor, //                   <--- border color
                width: 0.0,
              ),
            ),
            height: 1),
        Container(
            decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor,
              //    color: Theme.of(context).backgroundColor,
              border: Border.all(
                color: Theme.of(context)
                    .backgroundColor, //                   <--- border color
                width: 0.0,
              ),
            ),
            height: 25),
        Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            Container(
              height: 100,
              color: Theme.of(context).backgroundColor,
            ),
            Padding(
                padding: EdgeInsets.only(top: 60),
                child: Column(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 13.0,
                            color: Colors.black.withOpacity(.5),
                            offset: Offset(6.0, 7.0),
                          ),
                        ],
                        //shape: BoxShape.rectangle,
                        //border: Border.all(),
                        color: Colors.white,
                      ),
                      //color: Colors.white,

                      //replace this Container with your Card
                      // color: Colors.white,
                      height: 80.0,
                      child: Container(
                        padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Flexible(
                                flex: 1,
                                child: Container(
                                    height: 25,
                                    padding: EdgeInsets.only(right: 10),
                                    child: RaisedButton(
                                      padding:
                                          EdgeInsets.only(left: 5, right: 5),
                                      elevation: 0,
                                      child: Text(
                                        "Active UV Index",
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: !flagone
                                                ? Colors.green
                                                : Colors.white),
                                        textAlign: TextAlign.center,
                                      ),
                                      color:
                                          flagone ? Colors.green : Colors.white,
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                          color: Colors.white,
                                          width: 0.0,
                                        ),
                                        borderRadius:
                                            new BorderRadius.circular(3.0),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          flagone = true;
                                          if (flagtwo == true) {
                                            flagtwo = false;
                                          }
                                          if (flagthree == true) {
                                            flagthree = false;
                                          }
                                        });
                                        Navigator.push<dynamic>(
                                          context,
                                          MaterialPageRoute<dynamic>(
                                            builder: (BuildContext context) =>
                                                WeatherScreen(),
                                          ),
                                        );
                                      },
                                    ))),
                            ScopedModelDescendant<MainModel>(
                              builder: (context, child, model) => Flexible(
                                  flex: 1,
                                  child: Container(
                                      height: 25,
                                      padding: EdgeInsets.only(right: 10),
                                      child: RaisedButton(
                                        padding:
                                            EdgeInsets.only(left: 5, right: 5),
                                        elevation: 0,
                                        child: Text(
                                          "Find Skin Type",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: !flagtwo
                                                  ? Colors.green
                                                  : Colors.white),
                                          textAlign: TextAlign.center,
                                        ),
                                        color: flagtwo
                                            ? Colors.green
                                            : Colors.white,
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                            color: Colors.white,
                                            width: 0.0,
                                          ),
                                          borderRadius:
                                              new BorderRadius.circular(3.0),
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            flagtwo = true;
                                            if (flagone == true) {
                                              flagone = false;
                                            }
                                            if (flagthree == true) {
                                              flagthree = false;
                                            }
                                          });
                                          Navigator.pushNamed(
                                              context, '/skinPage');
                                        },
                                      ))),
                            ),
                            Container(
                                height: 25,
                                padding: EdgeInsets.only(right: 10),
                                child: RaisedButton(
                                  padding: EdgeInsets.only(left: 4, right: 4),
                                  elevation: 0,
                                  child: Text(
                                    "Find Risk Profile",
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: !flagthree
                                            ? Colors.green
                                            : Colors.white),
                                    textAlign: TextAlign.center,
                                  ),
                                  color:
                                      flagthree ? Colors.green : Colors.white,
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      color: Colors.white,
                                      width: 0.0,
                                    ),
                                    borderRadius:
                                        new BorderRadius.circular(3.0),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      flagthree = true;
                                      if (flagone == true) {
                                        flagone = false;
                                      }
                                      if (flagtwo == true) {
                                        flagtwo = false;
                                      }
                                    });
                                    Navigator.of(context)
                                        .pushNamed('/skinPage');
                                  },
                                )),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.green,
                      height: 1.5,
                    )
                  ],
                )),
            GestureDetector(
              child: Container(
                width: circleRadius,
                height: circleRadius,
                decoration:
                    ShapeDecoration(shape: CircleBorder(), color: Colors.white),
                child: Padding(
                  padding: EdgeInsets.all(circleBorderWidth),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(80)),
                    child: FadeInImage(fit: BoxFit.cover,
                      //   image: NetworkImage(product.image),
                      image: AssetImage('assets/bill_gate.jpg'),
                      placeholder: AssetImage('assets/profile.png',),
                    ),

                  ),
                ),
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute<dynamic>(
                    builder: (BuildContext context) => EditProfile()));
              },
            ),
          ],
        ),
      ],
    );
  }
}
