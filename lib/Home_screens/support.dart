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
  String title;
  String description;
  bool loading = false;
  bool _flag = false;
  final List<String> _dropdownValues = [
    "HEAD" ,
    "FOREHEAD" ,
    "FACE" ,
    "LEFT ARM" ,
    "Right ARM" ,
    "RIGHT THIGH" ,
    "Left THIGH" ,
    "RIGHT FEET" ,
    "Left FEET" ,
  ];
  final List<String> _dropdownValues2 = [
    "Problem logging in?" ,
    "Issue uploading picture" ,
    "Issue sending message" ,
    "Questions Related to Subscription" ,
    "General Customer Support" ,
  ];
  String placeOfMole;

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
        context: context ,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Make a Choice") ,
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: Row(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(left: 3) ,
                          child: Image.asset(
                            'assets/art.png' ,
                            width: 22 ,
                            height: 22 ,
                          ) ,
                        ) ,
                        SizedBox(
                          width: 12 ,
                        ) ,
                        Text("Gallery") ,
                      ] ,
                    ) ,
                    onTap: () {
                      _openGalery(context);
                    } ,
                  ) ,
                  Padding(
                    padding: EdgeInsets.all(8) ,
                  ) ,
                  GestureDetector(
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.camera ,
                          color: Theme
                              .of(context)
                              .highlightColor ,
                        ) ,
                        SizedBox(
                          width: 10 ,
                        ) ,
                        Text("Camera") ,
                      ] ,
                    ) ,
                    onTap: () {
                      _openCamera(context);
                    } ,
                  )
                ] ,
              ) ,
            ) ,
          );
        });
  }

  void _submitForm(Function postInquiry) async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    Map<String , dynamic> successInformation;
    successInformation = await postInquiry(title, FileImage,message,description);
    print(successInformation);
    if (successInformation['success'] == true) {
      Toast.show(
          "Thank you for submitting the request.we will get back to you shourtly." ,
          context ,
          duration: Toast.LENGTH_LONG ,
          gravity: Toast.BOTTOM);
      Timer(Duration(milliseconds: 2000) ,
              () async {
            Navigator.pop(context);
          });
    } else {
      showDialog<dynamic>(
        context: context ,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Alert' ,
              style: TextStyle(fontFamily: 'Bold') ,
            ) ,
            content: Text(
              successInformation['message'] ,
              style: TextStyle(fontFamily: 'Reguler') ,
            ) ,
            actions: <Widget>[
              FlatButton(
                child: Text('Okey') ,
                onPressed: () {
                  Navigator.of(context).pop();
                } ,
              )
            ] ,
          );
        } ,
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<void> _showLocationOfMoleDialogue(BuildContext context) {
    return showDialog(
      context: context ,
      builder: (BuildContext context) {
        return AlertDialog(title: Text("Please Select the Location of mole") ,
          content: StatefulBuilder(
            builder: (BuildContext context , StateSetter setState) {
              return Container(
                alignment: Alignment.center ,
                height: MediaQuery
                    .of(context)
                    .size
                    .height / 5 ,
                child: Column(
                  children: <Widget>[
                    DropdownButton(
                      items: _dropdownValues
                          .map((value) =>
                          DropdownMenuItem(
                            child: Text(value) ,
                            value: value ,
                          ))
                          .toList() ,
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
                      } ,
                      isExpanded: true ,
                      hint: Text('Select') ,
                      value: placeOfMole ,
                    ) ,
                    SizedBox(
                      height: 10 ,
                    ) ,
                    RaisedButton(
                      color: Theme
                          .of(context)
                          .accentColor ,
                      child: Text("Submit") ,
                      onPressed: () {
                        if (placeOfMole != null) {
                          Navigator.of(context).pop(true);
                          _showDialogue(context);
                        }
                      } ,
                    )
                  ] ,
                ) ,
              );
            } ,
          ) ,
        );
      } ,
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Theme.of(context).accentColor,
        title: Text("Contact us") ,
        actions: [
          Container(
              padding: EdgeInsets.only(right: 15) ,
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    child: Container(
                      padding: EdgeInsets.only(right: 5) ,
                      child: Icon(Icons.attach_file) ,
                    ) ,
                    onTap: () {
                      _showDialogue(context);
                    } ,
                  ) ,
                  ScopedModelDescendant<MainModel>(
                      builder: (context , child , model) =>
                          GestureDetector(
                            child: Icon(
                              Icons.send ,
                            ) ,
                            onTap: () {
                              SystemChannels.textInput.invokeMethod(
                                  'TextInput.hide');
                              _submitForm(model.postInquiry);
                            } ,
                          )) ,
                ] ,
              ))
        ] ,
      ) ,
      body: ListView(
        children: <Widget>[
          Form(
            key: _formKey ,
            child: Column(children: <Widget>[
              Container(
                  margin: const EdgeInsets.only(right: 20 , left: 20) ,
                  padding: EdgeInsets.only(top: 20) ,
                  child: TextFormField(
                    maxLines: 1 ,
                    decoration: InputDecoration(labelText: "Title" ,
                        errorStyle: TextStyle(color:Colors.red,fontSize: 14 ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)) ,
                          borderSide: BorderSide(
                              width: 1 , color: Theme
                              .of(context)
                              .backgroundColor) ,
                        ) ,
                        border: OutlineInputBorder(borderSide: BorderSide()) ,
                        filled: true ,
                        hintText: "Title" ,
                        fillColor: Colors.white) ,
                    keyboardType: TextInputType.emailAddress ,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Please enter title';
                      }
                    } ,
                    onSaved: (String value) {
                      title = value;
                    } ,
                  )) ,
              Padding(padding: EdgeInsets.only(left: 20 , right: 20 , top: 20) ,
                child:
                Container(decoration: BoxDecoration(
                  border: Border.all(width: 1.0 , color: Colors.blue) ,
                  borderRadius: BorderRadius.circular(4) ,) ,
                  padding: EdgeInsets.only(left: 20 , right: 20) ,
                  child: DropdownButton(
                    items: _dropdownValues2
                        .map((value) =>
                        DropdownMenuItem(
                          child: Text(value) ,
                          value: value ,
                        ))
                        .toList() ,
                    onChanged: (String value) {
                      setState(() {
                        message = value;
                        _flag = true;
                      });
                    } ,
                    isExpanded: true ,
                    hint: Text("What's this about") ,
                    value: message ,
                  ) ,) ,) ,
              _flag ? Container():
              Container(padding:EdgeInsets.only(left: 35,top: 5),alignment:Alignment.centerLeft,child: Text("Please select any option",style: TextStyle(color: Colors.red),),),

              Container(
                  margin: const EdgeInsets.only(right: 20 , left: 20) ,
                  padding: EdgeInsets.only(bottom: 20 , top: 20) ,
                  child: TextFormField(
                    maxLines: 1 ,
                    decoration: InputDecoration(errorStyle: TextStyle(color:Colors.red,fontSize: 14 ),
                        filled: true ,
                        hintText: "Description" ,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)) ,
                          borderSide: BorderSide(
                              width: 1 , color: Theme
                              .of(context)
                              .backgroundColor) ,
                        ) ,
                        border: OutlineInputBorder(borderSide: BorderSide()) ,
                        fillColor: Colors.white) ,
                    keyboardType: TextInputType.emailAddress ,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Please enter description';
                      }
                    } ,
                    onSaved: (String value) {
                      description = value;
                    } ,
                  )) ,
            ] ,) ,

          ) ,
          FileImage != null
              ? Image.file(
            FileImage ,
            height: 200 ,
            width: 200 ,
          )
              : Container() ,
          SizedBox(height: 20,),
          ScopedModelDescendant<MainModel>(
              builder: (BuildContext context , Widget child , MainModel model) {
                return
                  Container(margin: EdgeInsets.only(left: 70,right: 70),
                    height: 40,
//                    width: MediaQuery.of(context).size.width/3,
                    child: RaisedButton(
                      child: Text(
                        'SUBMIT',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 18),
                      ),
                      onPressed: () async {
                        if (!_formKey.currentState.validate()) {
                          if(message == null){
                            _flag = true;
                            print(_flag);
                          }
                          return;
                        }
                        _formKey.currentState.save();
                        _submitForm(model.postInquiry);
                      },
                      color: Theme.of(context).accentColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(5.0),
                      ),
                    ),
                  );
              }) ,
          ScopedModelDescendant<MainModel>(
              builder: (BuildContext context , Widget child , MainModel model) {
                return model.supportMessageLoading
                    ? AlertDialog(
                    content: Row(
                      children: <Widget>[
                        CircularProgressIndicator() ,
                        SizedBox(
                          width: 20 ,
                        ) ,
                        Text("Please wait") ,
                      ] ,
                    ))
                    : Container();
              })
        ] ,
      ) ,
    );
  }
}
