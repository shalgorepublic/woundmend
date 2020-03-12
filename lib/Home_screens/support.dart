import 'dart:async';

import 'package:derm_pro/scoped_models/main.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:scoped_model/scoped_model.dart';
import 'package:toast/toast.dart';
import 'package:flutter/services.dart';


class SupportScreen extends StatefulWidget {
  final model;

  SupportScreen(this.model);

  @override
  _SupportScreenState createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  File FileImage;
  String message;
  bool loading = false;

  _openGalery(BuildContext context) async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      FileImage = image;
    });
    Navigator.of(context).pop();
  }

  _openCamera(BuildContext context) async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      FileImage = image;
      print(FileImage.path);
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

  void _submitForm(Function postInquiry) async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    Map<String, dynamic> successInformation;
    successInformation = await postInquiry(message, FileImage);
    print(successInformation);
    if (successInformation['success'] == true) {
      Toast.show("Thank you for submitting the request.we will get back to you shourtly.", context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.BOTTOM);
      Timer(Duration(milliseconds: 2000),
              () async {
            Navigator.pop(context);
          });
    } else {
      showDialog<dynamic>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'An Error Occured',
              style: TextStyle(fontFamily: 'Bold'),
            ),
            content: Text(
              successInformation['message'],
              style: TextStyle(fontFamily: 'Reguler'),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Okey'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        },
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contact us"),
        actions: [
          Container(
              padding: EdgeInsets.only(right: 15),
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    child: Container(
                      padding: EdgeInsets.only(right: 5),
                      child: Icon(Icons.attach_file),
                    ),
                    onTap: () {
                      _showDialogue(context);
                    },
                  ),
                  ScopedModelDescendant<MainModel>(
                      builder: (context, child, model) => GestureDetector(
                            child: Icon(
                              Icons.send,
                            ),
                            onTap: () {
                              SystemChannels.textInput.invokeMethod('TextInput.hide');
                              _submitForm(model.postInquiry);
                            },
                          )),
                ],
              ))
        ],
      ),
      body: ListView(
        children: <Widget>[
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
          FileImage != null
              ? Image.file(
                  FileImage,
                  height: 200,
                  width: 200,
                )
              : Container(),
          ScopedModelDescendant<MainModel>(
              builder: (BuildContext context, Widget child, MainModel model) {
            return model.supportMessageLoading
                ? AlertDialog(
                    content: Row(
                    children: <Widget>[
                      CircularProgressIndicator(),
                      SizedBox(
                        width: 20,
                      ),
                      Text("Please wait"),
                    ],
                  ))
                : Container();
          })
        ],
      ),
    );
  }
}
