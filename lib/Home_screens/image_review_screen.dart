import 'package:derm_pro/scoped_models/main.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'dart:io';
import 'package:toast/toast.dart';

class ImageReviewScreen extends StatefulWidget {
  final Map<String, dynamic> data;

  ImageReviewScreen(this.data);

  @override
  _ImageReviewScreenState createState() => _ImageReviewScreenState();
}

class _ImageReviewScreenState extends State<ImageReviewScreen> {
  File _image;

  Future imagepicker() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image as File;
    });
    if (_image != null) {
      Navigator.push<dynamic>(
        context,
        MaterialPageRoute<dynamic>(
          builder: (context) => ImageReviewScreen(
              {'image': _image, 'location': widget.data['location']}),
        ),
      );
    }
  }

  Future<void> _showDialogue(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              content: Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(right: 20),
                child: CircularProgressIndicator(),
              ),
              Text(
                "Please wait...",
                style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Bold',
                    color: Theme.of(context).highlightColor),
              )
            ],
          ));
        });
  }

  Future<void> _showImageUploadedDialogue(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              content:Container(height:250,child:
              Column(
            children: <Widget>[
              Container(height: 100,
                child: Image.asset(
                  'assets/logo.png',
                ),
              ),
              Text(
                "Thanks for using dermpro app, we will get back to you shourtly.",
                style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Bold',
                    color: Theme.of(context).highlightColor),
              ),
              SizedBox(height: 50,),
              SizedBox(
                height: 40,
                width: MediaQuery.of(context).size.width/2,
                child: RaisedButton(
                  child: Text(
                    'Ok',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 18),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  color: Theme.of(context).accentColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(5.0),
                  ),
                ),
              )
            ],
          ))
          );
        });
  }

  void initState() {
    super.initState();
    setState(() {
      print("heloooooooooooo");
      print(widget.data['location']);
      _image = widget.data['image'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Review"),
      ),
      body: Column(
        children: <Widget>[
          _image != null
              ? Image.file(
                  _image,
                  height: MediaQuery.of(context).size.height / 2.3,
                  width: MediaQuery.of(context).size.width,
                )
              : Container(),
          Container(
            padding: EdgeInsets.only(top: 20, right: 30, left: 30),
            child: Text(
              "Make sure the photo is sharp, centered and free of hair or other obstructing objects.",
              style: TextStyle(fontSize: 16, fontFamily: "Reguler"),
            ),
          ),
          Container(
              padding: EdgeInsets.only(top: 50, left: 30, right: 30),
              alignment: Alignment.center,
              child: Column(
                children: <Widget>[
                  ScopedModelDescendant<MainModel>(builder:
                      (BuildContext context, Widget child, MainModel model) {
                    return SizedBox(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      child: RaisedButton(
                        child: Text(
                          'Submit Scan',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 18),
                        ),
                        onPressed: () async {
                          _showDialogue(context);
                          bool value = await model.postImage(
                              _image, widget.data['location']);
                          if (value) {
                            Navigator.of(context).pop(true);
                            Toast.show("Image Uploaded", context,
                                duration: Toast.LENGTH_SHORT,
                                gravity: Toast.BOTTOM);
                            _showImageUploadedDialogue(context);
                            Timer(Duration(milliseconds: 2000), () async {
                              //  Navigator.pop(context);
                            });
                          } else {
                            Navigator.of(context).pop(true);
                            Toast.show("Network Error", context,
                                duration: Toast.LENGTH_SHORT,
                                gravity: Toast.BOTTOM);
                          }
                          //  _submitPassword(model.forgotPassword);
                        },
                        color: Theme.of(context).accentColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(5.0),
                        ),
                      ),
                    );
                  }),
                  SizedBox(
                    height: 20,
                  ),
                  ScopedModelDescendant<MainModel>(builder:
                      (BuildContext context, Widget child, MainModel model) {
                    return SizedBox(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      child: RaisedButton(
                        child: Text(
                          'RETAKE',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 18),
                        ),
                        onPressed: () {
                          imagepicker();
                          Navigator.pop(context);
                          // _submit(model.update);
                        },
                        color: Theme.of(context).backgroundColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(5.0),
                        ),
                      ),
                    );
                  }),
                ],
              )),
        ],
      ),
    );
  }
}
