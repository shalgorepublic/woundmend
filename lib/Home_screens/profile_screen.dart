import 'dart:async';
import 'dart:io';
import 'package:derm_pro/Home_screens/alert_screen.dart';
import 'package:derm_pro/Home_screens/contact_us_screen.dart';
import 'package:derm_pro/Home_screens/edit_profile.dart';
import 'package:derm_pro/Home_screens/skin_result.dart';
import 'package:derm_pro/Home_screens/ui_elements_home/drawer.dart';
import 'package:derm_pro/Home_screens/weather/uv_index_page.dart';
import 'package:derm_pro/scoped_models/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

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
  bool modelFlag = true;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  FirebaseMessaging _firebaseMessaging = new FirebaseMessaging();

  @override
  void initState() {
    super.initState();
    _showModel();
    Timer(Duration(seconds: 7), () {
      _scaffoldKey.currentState.hideCurrentSnackBar();
    });
 //   new FirebaseNotifications().setUpFirebase();
  }



  void _showModel() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var Result = await widget.model.fetchUserData(widget.model.user.id);
    if (widget.model.alertFlag) {
      _showAlert(context);
    }
    if (!Result['completed']) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Container(
            child: Center(
                child: Text(
              "Connection dropped.",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            )),
            height: 15.0),
      ));
    }
  }

  void _showAlert(BuildContext context) {
    showDialog<void>(
        context: context,
        builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            content: AlertScreen()));
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
          key: _scaffoldKey,
          body: Container(
            color: Colors.white,
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
                              child: Container(
                            child: Theme(
                              data: Theme.of(context)
                                  .copyWith(accentColor: Theme.of(context).accentColor),
                              child: ContainerWithCircle(),
                            ),
                          ))
                        ]),
                      ),
                    ),
                  ];
                },
                body: Column(
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
                            padding: EdgeInsets.only(top: 20),
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
                  GestureDetector(
                    child: Container(
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
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushReplacementNamed(context, '/inboxScreen');
                    },
                  ),
                  GestureDetector(
                    child: Container(
                        padding: EdgeInsets.only(right: 50, top: 10),
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
                    onTap: () {
                      Navigator.push<dynamic>(
                        context,
                        MaterialPageRoute<dynamic>(
                          builder: (context) => ContactUsScreen(),
                        ),
                      );
                    },
                  )
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
  LocationData currentPositionLocation;

  void getLocation() async {
    LocationData currentLocation;
    var location = new Location();
    bool enabled = await location.serviceEnabled();
    currentLocation = await location.getLocation();
    setState(() {
      currentPositionLocation = currentLocation;
    });
    if (enabled == true && currentPositionLocation != null) {
      Navigator.push<dynamic>(
        context,
        MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => UvIndexPage({
            'lat': currentPositionLocation.latitude,
            'lng': currentPositionLocation.longitude
          }),
        ),
      );
    }
  }

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
                        padding: EdgeInsets.only(top: 15, left: 15, right: 15),
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
                                        getLocation();
                                        Timer(Duration(milliseconds: 1500),
                                            () async {
                                          var location = new Location();
                                          bool enabled =
                                              await location.serviceEnabled();
                                          print("helo check location on");
                                          print(enabled);
                                          if (enabled == true &&
                                              currentPositionLocation == null) {
                                            getLocation();
                                          }
                                        });
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
                                          model.skinType,
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
                                          if (!model.skinTypeSurveyFlag) {
                                            Navigator.pushNamed(
                                                context, '/skinPage');
                                          } else
                                            Navigator.push<dynamic>(
                                              context,
                                              MaterialPageRoute<dynamic>(
                                                builder:
                                                    (BuildContext context) =>
                                                        SkinResultScreen(model),
                                              ),
                                            );
                                        },
                                      ))),
                            ),
                            ScopedModelDescendant<MainModel>(
                                builder: (context, child, model) => Container(
                                    height: 25,
                                    padding: EdgeInsets.only(right: 10),
                                    child: RaisedButton(
                                      padding:
                                          EdgeInsets.only(left: 4, right: 4),
                                      elevation: 0,
                                      child: Text(
                                        model.skinType,
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: !flagthree
                                                ? Colors.green
                                                : Colors.white),
                                        textAlign: TextAlign.center,
                                      ),
                                      color: flagthree
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
                                          flagthree = true;
                                          if (flagone == true) {
                                            flagone = false;
                                          }
                                          if (flagtwo == true) {
                                            flagtwo = false;
                                          }
                                        });
                                        if (!model.skinTypeSurveyFlag) {
                                          Navigator.pushNamed(
                                              context, '/skinPage');
                                        } else
                                          Navigator.push<dynamic>(
                                            context,
                                            MaterialPageRoute<dynamic>(
                                              builder: (BuildContext context) =>
                                                  SkinResultScreen(model),
                                            ),
                                          );
                                      },
                                    ))),
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
                    child: FadeInImage(
                      fit: BoxFit.cover,
                      //   image: NetworkImage(product.image),
                      image: AssetImage('assets/bill_gate.jpg'),
                      placeholder: AssetImage(
                        'assets/profile.png',
                      ),
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
class FirebaseNotifications {
  FirebaseMessaging _firebaseMessaging;

  void setUpFirebase() {
    _firebaseMessaging = FirebaseMessaging();
    firebaseCloudMessaging_Listeners();

  }

  void firebaseCloudMessaging_Listeners() {
    if (Platform.isIOS) iOS_Permission();

    _firebaseMessaging.getToken().then((token) {
      print(token);
    });

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('on message $message');
      },
      onResume: (Map<String, dynamic> message) async {
        print('on resume $message');
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('on launch $message');
      },
    );
  }

  void iOS_Permission() {
    _firebaseMessaging.requestNotificationPermissions(
        IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
  }
}