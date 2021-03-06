import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:derm_pro/Home_screens/alert_screen.dart';
import 'package:derm_pro/Home_screens/contact_us_screen.dart';
import 'package:derm_pro/Home_screens/edit_profile.dart';
import 'package:derm_pro/Home_screens/helper_notification.dart';
import 'package:derm_pro/Home_screens/image_review_screen.dart';
import 'package:derm_pro/Home_screens/inbox_page.dart';
import 'package:derm_pro/Home_screens/skin_result.dart';
import 'package:derm_pro/Home_screens/ui_elements_home/drawer.dart';
import 'package:derm_pro/Home_screens/weather/uv_index_page.dart';
import 'package:derm_pro/Home_screens/your_scans.dart';
import 'package:derm_pro/models/read_chat_model.dart';
import 'package:derm_pro/scoped_models/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:camera_camera/camera_camera.dart';

import 'package:toast/toast.dart';

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
  final List<String> _dropdownValues = [
    "HEAD",
    "FOREHEAD",
    "FACE",
    "LEFT ARM",
    "RIGHT ARM",
    "RIGHT THIGH",
    "LEFT THIGH",
    "RIGHT FEET",
    "LEFT FEET",
  ];
  String placeOfMole;
  final notifications = FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    _showModel();
    Timer(Duration(seconds: 7), () {
      _scaffoldKey.currentState.hideCurrentSnackBar();
    });
    new FirebaseNotifications(widget.model).setUpFirebase();
    final settingsAndroid = AndroidInitializationSettings('app_icon');
    final settingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: (id, title, body, payload) =>
            onSelectNotification(payload));

    notifications.initialize(
        InitializationSettings(settingsAndroid, settingsIOS),
        onSelectNotification: onSelectNotification);
    super.initState();
  }

  Future onSelectNotification(String payload) async => await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => YourScans(widget.model)),
      );

  void _showModel() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var Result = await widget.model.fetchUserData(widget.model.user.id);
    if (widget.model.alertFlag) {
      _showAlert(context);
    }
    if (Result['completed'] == false) {
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
//            contentPadding: EdgeInsets.symmetric(vertical: 60.0),
            content: AlertScreen()));
  }

  void test() {
    setState(() {});
  }
  _openGalery(BuildContext context) async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
    Navigator.of(context).pop();
    if (_image != null) {
      Navigator.push<dynamic>(
        context,
        MaterialPageRoute<dynamic>(
          builder: (context) =>
              ImageReviewScreen({'image': _image, 'location': placeOfMole}),
        ),
      );
    }
  }
File val;
  _openCamera(BuildContext context) async {
    val = await showDialog(
        context: context,
        builder: (context) => Camera(
          mode: CameraMode.normal,
          orientationEnablePhoto: CameraOrientation.all,
          imageMask: CameraFocus.circle(
            color: Colors.black.withOpacity(0.5),
          ),
        ));
    setState(() {
      _image = val;
    });
    Navigator.of(context).pop();
    if (_image != null) {
      Navigator.push<dynamic>(
        context,
        MaterialPageRoute<dynamic>(
          builder: (context) =>
              ImageReviewScreen({'image': _image, 'location': placeOfMole}),
        ),
      );

  
  }}

  Future<void> _showImageDialogue(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Make a Choice"),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: Row(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(left: 3),
                          child: Image.asset(
                            'assets/art.png',
                            width: 22,
                            height: 22,
                          ),
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Text("Gallery"),
                      ],
                    ),
                    onTap: () {
                      _openGalery(context);
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                  ),
                  GestureDetector(
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.camera,
                          color: Theme.of(context).highlightColor,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text("Camera"),
                      ],
                    ),
                    onTap: () {
                      _openCamera(context);
                    },
                  )
                ],
              ),
            ),
          );
        });
  }

  Future<void> _showDialogue(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title:
            Text("Please Select the Location of mole"),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                alignment: Alignment.center,
                height: MediaQuery.of(context).size.height / 5,
                child: Column(
                  children: <Widget>[
                    DropdownButton(
                      items: _dropdownValues
                          .map((value) => DropdownMenuItem(
                                child: Text(value),
                                value: value,
                              ))
                          .toList(),
                      onChanged: (String value) {
                        setState(() {
                          placeOfMole = value;
                        });
                        /* Timer(Duration(milliseconds: 500), () {
                if (placeOfMole != null) {
                //  Navigator.of(context).pop(true);
                 // imagepicker();
                }
              });*/
                      },
                      isExpanded: true,
                      hint: Text('Select an option'),
                      value: placeOfMole,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    RaisedButton(
                      color: Theme.of(context).accentColor,
                      child: Text(
                        "SUBMIT",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        if (placeOfMole != null) {
                          Navigator.of(context).pop(true);
                          _showImageDialogue(context);
                        } else
                          Toast.show("Please select any option", context,
                              duration: Toast.LENGTH_LONG,
                              gravity: Toast.CENTER);
                      },
                    )
                  ],
                ),
              );
            },
          ),
        );
      },
    );
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
                      automaticallyImplyLeading: true,
                      backgroundColor: Theme.of(context).accentColor,
                      floating: false,
                      pinned: true,
                      flexibleSpace: ScopedModelDescendant<MainModel>(
                          builder: (context, child, model) => FlexibleSpaceBar(
                                centerTitle: true,
                                title: Text(
                                  '${model.user.firstName[0].toUpperCase()}${model.user.firstName.substring(1)}',
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
                              data: Theme.of(context).copyWith(
                                  accentColor: Theme.of(context).accentColor),
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
                              "At the top you will find personal information about at you skin type, risk profile and local UV index.",
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
                                "Your skin checks will be stored in folders here."),
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
                backgroundColor: Theme.of(context).accentColor,
                elevation: 0,
                onPressed: () {
                  _showDialogue(context);
                  //imagepicker();
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
              color: Theme.of(context).accentColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
              ScopedModelDescendant<MainModel>(
              builder: (context, child, model) =>
                  GestureDetector(
                    child: Container(
                      padding: EdgeInsets.only(left: 50, top: 10),
                      child: Column(
                        children: <Widget>[
                          model.notificationFlag?
                          Container(padding: EdgeInsets.only(),
                              width: 26,
                              height: 25,
                              child: new Image.asset(
                                'assets/inbox_icon.png',
                              )):
                          Icon(
                           Icons.mail,
                            color:Colors.white,
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
                      //   Navigator.pop(context);
                      model.setNotificationFlag();
                      Navigator.pushNamed(context, '/yourScansPage');
                    },
                  )),
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
                    .accentColor, //                   <--- border color
                width: 0.0,
              ),
            ),
            height: 1),
        Container(
            decoration: BoxDecoration(
              color: Theme.of(context).accentColor,
              //    color: Theme.of(context).backgroundColor,
              border: Border.all(
                color: Theme.of(context)
                    .accentColor, //                   <--- border color
                width: 0.0,
              ),
            ),
            height: 25),
        Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            Container(
              height: 100,
              color: Theme.of(context).accentColor,
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
                        padding: EdgeInsets.only(left: 35, right: 35),
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
                                                ? Theme.of(context).backgroundColor
                                                : Colors.white),
                                        textAlign: TextAlign.center,
                                      ),
                                      color: flagone
                                          ? Theme.of(context).backgroundColor
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
                                          if (enabled == true &&
                                              currentPositionLocation == null) {
                                            getLocation();
                                          }
                                        });
                                      },
                                    ))),
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
                                                ? Theme.of(context).backgroundColor
                                                : Colors.white),
                                        textAlign: TextAlign.center,
                                      ),
                                      color: flagthree
                                          ? Theme.of(context).backgroundColor
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
                      color: Theme.of(context).accentColor,
                      height: 2,
                    )
                  ],
                )),
            ScopedModelDescendant<MainModel>(
                builder: (context, child, model) => GestureDetector(
                      child: Container(
                        width: circleRadius,
                        height: circleRadius,
                        decoration: ShapeDecoration(
                            shape: CircleBorder(), color: Colors.white),
                        child: Padding(
                          padding: EdgeInsets.all(circleBorderWidth),
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(80)),
                            child: model.user.image != null
                                ? FancyShimmerImage(
                                    imageUrl: model.user.image,
                                  )
                                : Image.asset(
                                    'assets/profile.png',
                                  ),
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute<dynamic>(
                            builder: (BuildContext context) => EditProfile(model)));
                      },
                    )),
          ],
        ),
      ],
    );
  }
}

class FirebaseNotifications {
  final model;
  final notifications = FlutterLocalNotificationsPlugin();

  FirebaseNotifications(this.model);

  FirebaseMessaging _firebaseMessaging;

  void setUpFirebase() {
    _firebaseMessaging = FirebaseMessaging();
    firebaseCloudMessaging_Listeners();
  }

  void firebaseCloudMessaging_Listeners() {
    if (Platform.isIOS) iOS_Permission();

    _firebaseMessaging.getToken().then((token) {
      model.updateToken(token);
    });

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
//        print(message['notification']['title']);
      model.setNotificationFlag();
        showOngoingNotification(notifications,
            title: message['notification']['title'],
            body: message['notification']['body']);
        //  model.fetchQueriesSpots();
        print(message);
        print('tessssttttt');

        var id = int.parse(message['data']['obj_id']);
        bool flag = false;
//        print(model.readFlagObjects);
//        print(model.readFlagObjects.length);
        if (model.readFlagObjects.length == 0) {
//          print("i am herepoo 111");
//          print(id);
          ChatReadFlag temp = new ChatReadFlag(id: id, flag: true);
//          print(temp.id);
//          print(model.readFlagObjects.first.id);
          model.readFlagObjects.add(temp);

          print(model.readFlagObjects.first.id);
          print("hehhadasdasdas");
        } else {
          for (int i = 0; i < model.readFlagObjects.length; i++) {
            if (model.readFlagObjects[i].id == id) {
              model.readFlagObjects[i].flag = true;
              flag = true;
              break;
            }
          }
          if (flag == false) {
            ChatReadFlag temp = new ChatReadFlag(id: id, flag: true);
            model.readFlagObjects.add(temp);
          }
//          ChatReadFlag temp = model.readFlagObjects.singlewhere((i)=> i.id == int.parse(id));
//          print(temp.id);
          print("i am herepoo 22");
        }
        model.justtosetstate();
        print('tessssttttt');
        Map<String, dynamic> Result = await model.fetchQueriesSpots();
//        print("length of queries");
//        print(model.readFlagObjects);
//        print(model.allQueries.length);
//        print("helo lebgth");
      },
      onResume: (Map<String, dynamic> message) async {
        print('on resume $message');
        model.setNotificationFlag();
        model.fetchQueriesSpots();
        showOngoingNotification(notifications,
            title: 'helo on resume', body: 'helo body');
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('on launch $message');
      },
      /* onBackgroundMessage: (Map<String, dynamic> message) async {
        print('on background message $message');
      },*/
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

