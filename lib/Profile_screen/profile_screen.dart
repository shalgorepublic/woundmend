import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  double screenWidth;
  File _image;
  File imageSource;
  bool imagePickerflag = false;

  Future imagepicker() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    var imageSource = await ImagePicker.pickImage(source: ImageSource.gallery);

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
    screenWidth = MediaQuery.of(context).size.width;
    return new WillPopScope(
        onWillPop: _onBackPressed,
        child:
      Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Johen Micheal",
          style: TextStyle(fontSize: 22),
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(150.0),
            child: Container(
              child: Theme(
                data: Theme.of(context).copyWith(accentColor: Colors.blue),
                child: ContainerWithCircle(),
              ),
            )),
      ),
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            AppBar(
              automaticallyImplyLeading: false,
              title: Text('Johen Micheal'),
            ),
            ListTile(
              leading: Icon(Icons.edit),
              title: Text('Manage Products'),
              onTap: () {
                //  Navigator.pushReplacementNamed(context, '/admin');
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.assignment),
              title: Text('Task Page'),
              onTap: () {
                // Navigator.of(context).push<dynamic>(MaterialPageRoute<dynamic>(
                //    builder: (BuildContext context) => TaskScreen()));
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.assignment),
              title: Text('Second Task Page'),
              onTap: () {
                //  Navigator.of(context).push<dynamic>(MaterialPageRoute<dynamic>(
                //      builder: (BuildContext context) => MyApp()));
              },
            ),
            Divider(),
            // LogoutListTile(),
          ],
        ),
      ),
      body:ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 10),
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.only(top: 20, left: 30, right: 30),
              child: Column(
                children: <Widget>[
                  Text(
                    "Welcome to your Profile Page",
                    style: TextStyle(fontSize: 16),
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
                    child: Text("Your skin checks will be stored in the here."),
                  )
                ],
              ),
            ),
          )
        ],
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(top: 20),
        child: SizedBox(
          height: 60,
          width: 60,
          child: FloatingActionButton(
            backgroundColor: Colors.transparent,
            elevation: 0,
            onPressed: () {
              imagepicker();
            },
            child: Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 4),
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: const Alignment(0.7, -0.5),
                  end: const Alignment(0.6, 0.5),
                  colors: [
                    Color(0xFF53a78c),
                    Color(0xFF70d88b),
                  ],
                ),
              ),
              child: Icon(Icons.photo_camera, size: 30),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Container(
          height: 50,
          color: Colors.white,
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
            height: 15),
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
                                child: Container(height:25,
                                    padding: EdgeInsets.only(right: 10),
                                    child: RaisedButton(
                                      padding: EdgeInsets.only(left: 5,right: 5),
                                      elevation: 0,
                                      child: Text(
                                        "Active UV Index",
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: !flagone
                                                ? Theme.of(context).accentColor
                                                : Colors.white),
                                        textAlign: TextAlign.center,
                                      ),
                                       color: flagone
                                          ? Theme.of(context).accentColor
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
                                      },
                                    ))),
                            Flexible(
                                flex: 1,
                                child: Container(height:25,
                                    padding: EdgeInsets.only(right: 10),
                                    child: RaisedButton(
                                      padding: EdgeInsets.only(left: 5,right: 5),
                                      elevation: 0,
                                      child: Text(
                                        "Find Skin Type",
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: !flagtwo
                                                ? Theme.of(context).accentColor
                                                : Colors.white),
                                        textAlign: TextAlign.center,
                                      ),
                                      color: flagtwo
                                          ? Theme.of(context).accentColor
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
                                      },

                                    ))),
                            Flexible(
                                flex: 1,
                                child: Container(height:25,
                                    padding: EdgeInsets.only(right: 10),
                                    child: RaisedButton(
                                      padding: EdgeInsets.only(left: 4,right: 4),
                                      elevation: 0,
                                      child: Text(
                                        "Find Risk Profile",
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: !flagthree
                                                ? Theme.of(context).accentColor
                                                : Colors.white),
                                        textAlign: TextAlign.center,
                                      ),
                                      color: flagthree
                                          ? Theme.of(context).accentColor
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
                                      },
                                    ))),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.green,
                      height: 2,
                    )
                  ],
                )),
            Container(
              width: circleRadius,
              height: circleRadius,
              decoration:
                  ShapeDecoration(shape: CircleBorder(), color: Colors.white),
              child: Padding(
                padding: EdgeInsets.all(circleBorderWidth),
                child: DecoratedBox(
                  decoration: ShapeDecoration(
                      shape: CircleBorder(),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            'https://upload.wikimedia.org/wikipedia/commons/a/a0/Bill_Gates_2018.jpg',
                          ))),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
