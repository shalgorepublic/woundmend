import 'package:camera_camera/camera_camera.dart';
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
  File val;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String message;
  Future imagepicker() async {
//    var image = await ImagePicker.pickImage(source: ImageSource.camera);
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
    if (_image != null) {
     /* Navigator.push<dynamic>(
        context,
        MaterialPageRoute<dynamic>(
          builder: (context) => ImageReviewScreen(
              {'image': _image, 'location': widget.data['location']}),
        ),
      );*/
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
                "Thanks for using dermpro app, we will get back to you shortly.",
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
                    'OK',
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
      body:SingleChildScrollView(child:
      Column(
        children: <Widget>[
          _image != null
              ? Image.file(
                  _image,
                  height: MediaQuery.of(context).size.height / 2.5,
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
          Form(
            key: _formKey,
            child: Container(
                margin: const EdgeInsets.only(right: 20, left: 20),
                padding: EdgeInsets.only(bottom: 20, top: 20),
                child: TextFormField(
                  maxLines: 2,
                  decoration: InputDecoration(
                      filled: true,
                      hintText: "Description",
                      fillColor: Colors.white),
                  keyboardType: TextInputType.emailAddress,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Please enter description';
                    }
                  },
                  onSaved: (String value) {
                    message = value;
                  },
                )),
          ),
          Container(
              padding: EdgeInsets.only( left: 30, right: 30),
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
                          'SUBMIT SCAN',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 18),
                        ),
                        onPressed: () async {
                          if (!_formKey.currentState.validate()) {
                            return;
                          }
                          _formKey.currentState.save();
                          _showDialogue(context);

                         /* bool value = await model.postImage(
                              _image, widget.data['location']);*/
                           bool value = await model.postImageToGetDisease(
                              _image,widget.data['location'],message);
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
                         // Navigator.pop(context);
                          // _submit(model.update);
                        },
                        color: Theme.of(context).backgroundColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(5.0),
                        ),
                      ),
                    );
                  }),
                  SizedBox(height: 10,)
                ],
              )),
        ],
      )),
    );
  }
}
