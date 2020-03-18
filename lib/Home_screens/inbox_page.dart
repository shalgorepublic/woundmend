import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import 'package:bubble/bubble.dart';
import 'package:derm_pro/Home_screens/ui_elements_home/drawer.dart';
import 'package:derm_pro/scoped_models/main.dart';
import 'package:dio/dio.dart';
import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class InboxScreen extends StatefulWidget {
  final id;
  final model;

  InboxScreen({this.id, this.model});

  @override
  _InboxScreenState createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  TextEditingController _textFieldController = TextEditingController();
  ScrollController _scrollController = new ScrollController();
  bool _isLoading = true;
  Duration position;
  String localFilePath;
  int last_position;
  Stream<int> stream;
  Timer timer;
  ScrollController _rrectController = ScrollController();
  File imageTaken;
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

  @override
  void initState() {
    // TODO: implement initState

    timer = Timer.periodic(Duration(seconds: 5) , (Timer t) => fetchData());

    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
  Future<void> _showLocationOfMoleDialogue(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(title: Text("Please Select the Location of mole"),
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
                      hint: Text('Select'),
                      value: placeOfMole,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    RaisedButton(
                      color: Theme.of(context).accentColor,
                      child: Text("SUBMIT",style: TextStyle(color: Colors.white),),
                      onPressed: () {
                        if (placeOfMole != null) {
                          Navigator.of(context).pop(true);
                          _showDialogue(context);
                        }
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
  Future<void> _showImageDialogue(BuildContext context, data) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(contentPadding: EdgeInsets.all(0),
              title: Container(
                  alignment: Alignment.center,
                 /* child: Text('Location of mole:${data.querySpotPlace}')),*/
                  child: Text('Location of mole:Left')),
            content: Container(
                child: CachedNetworkImage(
                      imageUrl:
                      'http://dermpro.herokuapp.com${data}',
                      placeholder: (context, url) =>
                      new
                     Center(child:Column(mainAxisSize:MainAxisSize.min,children: <Widget>[
                        CircularProgressIndicator(),
                      ],)),
                      errorWidget: (context, url, error) =>
                      new Icon(Icons.error),
                    ),
          ));
        });
  }
  void fetchData() async {
    Map<String , dynamic> result = await widget.model.fetchQueriesSpots();
    print(result);
    if (result['success'] == true) {
      setState(() {
        print("helo sahhhahahahhaid");
      });
    }
  }
  _openGalery(BuildContext context) async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageTaken = image;
    });
    Navigator.of(context).pop();
  }

  _openCamera(BuildContext context) async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      imageTaken = image;
      print(imageTaken.path);
    });
    Navigator.of(context).pop();
  }

  Future<void> _showDialogue(BuildContext context) {
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

  @override
  Widget build(BuildContext context) {
    var feedlist = widget.model.allQueries;
    return WillPopScope(
        onWillPop: () {
          Navigator.pop(context);
          Navigator.pushReplacementNamed(context , '/yourScansPage');
        } ,
        child: Scaffold(
          appBar: AppBar(title: Text("Inbox")) ,
          drawer: DrawerBuilder() ,
          body: ScopedModelDescendant<MainModel>(
              builder: (context , child , model) =>
                  Container(
                      height: MediaQuery
                          .of(context)
                          .size
                          .height ,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width ,
                      margin: EdgeInsets.only(bottom: 10) ,
                      child: DraggableScrollbar.rrect(
                        alwaysVisibleScrollThumb: true ,
                        backgroundColor: Theme
                            .of(context)
                            .backgroundColor ,
                        controller: _rrectController ,
                        labelTextBuilder: (offset) =>
                            Text("${offset.floor()}") ,
                        child: ListView.builder(
                          itemCount: feedlist
                              .singleWhere((element) => element.id == widget.id)
                              .feedbacks
                              .length ,
                          controller: _rrectController ,
                          reverse: true ,
                          shrinkWrap: true ,
                          itemBuilder: (context , index) {
                            return Container(
                                margin: EdgeInsets.only(bottom: 2) ,
                                child: feedlist
                                    .singleWhere((element) =>
                                element.id == widget.id)
                                    .feedbacks[index]
                                    .userRole ==
                                    'doctor'
                                    ? Container(
                                  child: Column(
                                    children: <Widget>[
                                      Bubble(
                                          margin: BubbleEdges.only(
                                              top: 10 , right: 80) ,
                                          nip: BubbleNip.leftTop ,
                                          color: Color.fromRGBO(
                                              225 , 255 , 199 , 1.0) ,
                                          alignment: Alignment.topLeft ,
                                          child: Container(
                                              child: Column(
                                                children: <Widget>[
                                                  Align(
//                              width: 100,
//                              color: Colors.blueGrey,
                                                    alignment: Alignment
                                                        .topLeft ,
                                                    child: Text(feedlist
                                                        .singleWhere((
                                                        element) =>
                                                    element.id ==
                                                        widget.id)
                                                        .feedbacks[index]
                                                        .message) ,
                                                  ) ,
                                                  Align(
                                                      alignment:
                                                      Alignment.topLeft ,
                                                      child: Padding(
                                                        padding: EdgeInsets
                                                            .only(
                                                            left: 10 , top: 2) ,
                                                        child: Text(
                                                          DateFormat.MMMMd()
                                                              .add_jm()
                                                              .format(feedlist
                                                              .singleWhere(
                                                                  (element) =>
                                                              element
                                                                  .id ==
                                                                  widget
                                                                      .id)
                                                              .feedbacks[
                                                          index]
                                                              .createdAt) ,
                                                          style: TextStyle(
                                                              fontSize: 10 ,
                                                              color: Colors
                                                                  .blueGrey) ,
                                                        ) ,
                                                      )) ,
                                                ] ,
                                              ))) ,
                                      feedlist
                                          .singleWhere((element) =>
                                      element.id == widget.id)
                                          .feedbacks[index]
                                          .image !=
                                          null
                                          ?GestureDetector(child:
                                      Container(
                                          padding: EdgeInsets.only(
                                              left: 10 , top: 5) ,
                                          alignment: Alignment.topLeft ,
                                          child: ClipRRect(
                                              child: Image.network(
                                                  'http://dermpro.herokuapp.com${feedlist
                                                      .singleWhere((element) =>
                                                  element.id == widget.id)
                                                      .feedbacks[index]
                                                      .image}' ,
                                                  width: 100 ,
                                                  height: 100 ,
                                                  fit: BoxFit.fill))),onTap: (){
                                            _showImageDialogue(context, feedlist
                                                .singleWhere((element) =>
                                            element.id == widget.id)
                                                .feedbacks[index]
                                                .image);
                                      },)
                                          : Container()
                                    ] ,
                                  ) ,
                                )
                                :Container(child: Column(children: <Widget>[
                                  Bubble(
                                      margin: BubbleEdges.only(top: 10 ,
                                          left: 80) ,
                                      nip: BubbleNip.rightTop ,
                                      style: BubbleStyle(
                                          padding: BubbleEdges.all(10)) ,
                                      color: Color.fromRGBO(212 , 234 , 244 ,
                                          1.0) ,
                                      alignment: Alignment.topRight ,
                                      child: Container(
                                          child: Column(
                                            children: <Widget>[
                                              Container(
                                                child: Align(
//                              width: 100,
//                              color: Colors.blueGrey,
                                                  alignment: Alignment.topRight ,
                                                  child: Text(feedlist
                                                      .singleWhere((element) =>
                                                  element.id == widget.id)
                                                      .feedbacks[index]
                                                      .message) ,
                                                ) ,
                                              ) ,
                                              Align(
                                                  alignment: Alignment.topRight ,
                                                  child: Padding(
                                                      padding: EdgeInsets.only(
                                                          right: 10 , top: 2) ,
                                                      child: Text(
                                                        DateFormat.MMMMd()
                                                            .add_jm()
                                                            .format(feedlist
                                                            .singleWhere(
                                                                (element) =>
                                                            element.id ==
                                                                widget.id)
                                                            .feedbacks[index]
                                                            .createdAt) ,
                                                        style:
                                                        TextStyle(fontSize: 10) ,
                                                      ))) ,
                                            ] ,
                                          )
                                      )),
                                  feedlist
                                      .singleWhere((element) =>
                                  element.id == widget.id)
                                      .feedbacks[index]
                                      .image !=
                                      null

                                      ?
                                      GestureDetector(child:
                                  Container(
                                      padding: EdgeInsets.only(
                                          right: 10 , top: 5) ,
                                      alignment: Alignment.topRight ,
                                      child: ClipRRect(
                                          child: Image.network(
                                              'http://dermpro.herokuapp.com${feedlist
                                                  .singleWhere((element) =>
                                              element.id == widget.id)
                                                  .feedbacks[index]
                                                  .image}' ,
                                              width: 100 ,
                                              height: 100 ,
                                              fit: BoxFit.fill))),onTap: (){
                                _showImageDialogue(context, feedlist
                                .singleWhere((element) =>
                            element.id == widget.id)
                                .feedbacks[index]
                                .image);
                          },)
                                      : Container()
                                ],),)
                            );
                          } ,
                        ) ,
                      ))) ,
          bottomNavigationBar: Padding(
            padding: MediaQuery
                .of(context)
                .viewInsets ,
            child: Container(
              height: 60 ,
              padding: EdgeInsets.symmetric(horizontal: 5) ,
              color: Colors.white ,
              child: Row(
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.all(2) ,
                      height: 50 ,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width/1.3,
                      alignment: Alignment.center ,
//                  color: hexToColor('#3A3171'),
                      child: TextField(
                        controller: _textFieldController ,
                        textAlign: TextAlign.left ,
                        decoration: new InputDecoration(
                            border: new OutlineInputBorder(  borderSide: BorderSide(color: Theme.of(context).backgroundColor),
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(5.0) ,
                              ) ,
                            ) ,
                            hintStyle: new TextStyle(color: Colors.grey[800]) ,
                            hintText: "Type your message..." ,
                            fillColor: Colors.white70) ,
                      )) ,
                  GestureDetector(
                    child: Container(
                      child: Icon(Icons.attach_file),
                    ),
                    onTap: () {
                      _showLocationOfMoleDialogue(context);
                    },
                  ),
                  SizedBox(width: 5,),
                  GestureDetector
                    (child:Icon(
                        Icons.send ,
                        color: Theme
                            .of(context)
                            .backgroundColor ,
                        size: 30.0 ,
                        semanticLabel: 'Send your message!' ,
                      ) ,
                      onTap: () {
                        if (_textFieldController.text
                            .toString()
                            .isNotEmpty) {
                          var msg = _textFieldController.text;
                          _textFieldController.text = '';
                          SystemChannels.textInput.invokeMethod('TextInput.hide');
                          sendMsg(imageTaken,msg,placeOfMole);
                          setState(() {
                            imageTaken =null;
                          });
                        }

                        else {
                          //   showToast("Please enter something",
                          //        gravity: Toast.BOTTOM);
                        }

                        // showToast(_textFieldController.text.toString(),gravity: Toast.BOTTOM);
                      })
                ] ,
              ) ,
            ) ,
          ) ,
        ));
  }


  void sendMsg(File fileImage , message,locationOfMole) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String token = prefs.get('token');
    print(token);
    print(fileImage);
    print("helo image");
    print(message);
    print(locationOfMole);
    if (fileImage != null) {
      print("helo image");
      FormData formData = FormData.fromMap({
        "message": message,
        "query_spot_place":locationOfMole,
        "image":
          await MultipartFile.fromFile(fileImage.path ,
              filename: fileImage.toString()),
      });
      Response response;
      try {
        var dio = Dio();
        response = (await dio.post(
          "http://dermpro.herokuapp.com//api/v1/query_spots/${widget
              .id}/feedback",
          data: formData,
          options: new Options(
            headers: {HttpHeaders.authorizationHeader: token} ,
          ) ,
        ));
        print(response.statusCode);
        print("message respoce");
        print(response);
        if (response.statusCode == 200) {
          print('request succedes');
          return print("request success");
        } else
          return print("request fail");
        print("server Error");
      } catch (e) {
        print(e);
        //  _supportMessageLoading = false;
        //  notifyListeners();
        print('helo error');
        return print("Internet error");
      }
    } else {
      print("helo null image");
      FormData formData = FormData.fromMap({
        "message": message ,
      });
      Response response;

      try {
        var dio = Dio();
        response = (await dio.post(
          "http://dermpro.herokuapp.com//api/v1/query_spots/${widget
              .id}/feedback" ,
          data: formData ,
          options: new Options(
            headers: {HttpHeaders.authorizationHeader: token} ,
          ) ,
        ));

        print(response.statusCode);
        print("message respoce");
        print(response);
        if (response.statusCode == 200) {
          print('request succedes');
          return print("request success");
        } else
          return print("request fail");
        print("server Error");
      } catch (e) {
        print(e);
        print('helo error');
        return print("Internet error");
      }
    }
  }
}
