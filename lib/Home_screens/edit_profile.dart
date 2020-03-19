import 'dart:io';
import 'package:derm_pro/registration_screens/forgot_password_success.dart';
import 'package:derm_pro/scoped_models/main.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class EditProfile extends StatefulWidget {
  final model;
  EditProfile(this.model);
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final double circleRadius = 150.0;
  final double circleBorderWidth = 5.0;
  int _radioValue1 = 0;
  int correctScore = 0;
  String gender;

  void _handleRadioValueChange1(int value) {
    setState(() {
      _radioValue1 = value;
      if(_radioValue1 == 0){
        gender = 'Male';
      }
      else
        {
          gender = "Female";
        }
      widget.model.changeGender(gender);
    });
  }
  @override
  void initState() {
    // TODO: implement initState

    if(widget.model.gender == 'Male'){
      setState(() {
        _radioValue1 = 0;
      });
    }
    else
      {
        setState(() {
          _radioValue1 = 1;
        });
      }

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).backgroundColor,
          centerTitle: true,
          title: ScopedModelDescendant<MainModel>(
              builder: (BuildContext context, Widget child, MainModel model) {
            return Text(
                '${model.user.firstName[0].toUpperCase()}${model.user.firstName.substring(1)}' +
                    " " +
                    model.user.lastName);
          }),
          bottom: PreferredSize(
              preferredSize: const Size.fromHeight(160.0),
              child: Container(
                child: Theme(
                  data: Theme.of(context).copyWith(accentColor: Colors.blue),
                  child: Column(
                    children: <Widget>[
                      Container(
                        color: Colors.white,
                        height: 1,
                      ),
                      ScopedModelDescendant<MainModel>(
                          builder: (context, child, model) =>
                              ContainerWithCircle(model))
                    ],
                  ),
                ),
              )),
        ),
        body: ListView(children: <Widget>[
          Container(
              padding: EdgeInsets.only(top: 20, right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Radio(
                    focusColor: Colors.blue,
                    activeColor: Theme.of(context).accentColor,
                    value: 0,
                    groupValue: _radioValue1,
                    onChanged: _handleRadioValueChange1,
                  ),
                  new Text(
                    'Male',
                    style: new TextStyle(
                        fontSize: 16.0,
                        color: _radioValue1 == 0
                            ? Theme.of(context).accentColor
                            : Colors.black),
                  ),
                  new Radio(
                    focusColor: Theme.of(context).accentColor,
                    value: 1,
                    groupValue: _radioValue1,
                    onChanged: _handleRadioValueChange1,
                  ),
                  new Text(
                    'Female',
                    style: new TextStyle(
                        fontSize: 16.0,
                        color: _radioValue1 == 1
                            ? Theme.of(context).accentColor
                            : Colors.black),
                  ),
                ],
              )),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
              child: ScopedModelDescendant<MainModel>(builder:
                  (BuildContext context, Widget child, MainModel model) {
                return RegisterForm({'model': model, 'value': _radioValue1});
              }),
            ),
          ),
        ]));
  }
}

class ContainerWithCircle extends StatefulWidget {
  final model;

  ContainerWithCircle(this.model);

  @override
  _ContainerWithCircleState createState() => _ContainerWithCircleState();
}

class _ContainerWithCircleState extends State<ContainerWithCircle> {
  final double circleRadius = 80.0;
  final double circleBorderWidth = 3.0;
  File _image;

  _openGalery(BuildContext context) async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('avatar');
    print(_image);
    widget.model.removeImage();
    bool result = await widget.model.saveImage(_image);
    Navigator.of(context).pop();
  }
  Future getImagefromCamera() async{
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
    });
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('avatar');
    bool result =await widget.model.saveImage(_image);
    Navigator.of(context).pop();
  }

  Future<void> _showDialogue(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Make a Choive"),
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
                        Text("Galery"),
                      ],
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
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
                      Navigator.of(context).pop();
                      getImagefromCamera();
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
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: circleRadius / circleRadius),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15)),
            ),
            //replace this Container with your Card

            height: 170.0,
          ),
        ),
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
                        child:model.user.image != null
                              ? FancyShimmerImage(
                            imageUrl: model.user.image,
                          )
                              :  _image != null ? Image.file(_image,fit: BoxFit.cover,):
                          Image.asset(
                                  'assets/profile.png',
                        ),
                      ),
                    ),
                  ),
                  onTap: () {
                    _showDialogue(context);
                  },
                )),
        Container(
          padding: EdgeInsets.only(top: 50, left: 80),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            //color: Colors.white,
            padding: EdgeInsets.all(0.0),
            child: Icon(
              Icons.edit,
              color: Theme.of(context).backgroundColor,
              size: 20,
            ),
          ),
        ),
        ScopedModelDescendant<MainModel>(
            builder: (BuildContext context, Widget child, MainModel model) {
          return Padding(
            padding: EdgeInsets.only(top: 120),
            child: Container(
                color: Theme.of(context).backgroundColor,
                child: Text(
                  model.user.email,
                  style: TextStyle(color: Colors.white),
                )),
          );
        }),
      ],
    );
  }
}

class RegisterForm extends StatefulWidget {
  //const RegisterForm({Key key}) : super(key: key);
  final object;

  RegisterForm(this.object);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String firstName;
  String lastName;
  String dob= DateFormat('dd-MMM-yyyy').format(new DateTime(DateTime.now().year - 16));
  int userId;
  bool loading = false;
  String gender;
  String userEmail;
  String dateHint;
  DateTime lastDatePicking;
  DateTime selectedDate = DateTime.parse("1970-01-01T11:00:00.000Z");

  @override
  void initState() {
    firstName = widget.object['model'].user.firstName;
    lastName = widget.object['model'].user.lastName;
    dob = widget.object['model'].user.dob;
    userEmail = widget.object['model'].user.email;
    userId = widget.object['model'].user.id;
//    gender = widget.object['model'].user.id;
    setState(() {
      if (widget.object['value'] == 0) {
        print("0");
        gender = 'Male';
      } else {
        print('1');
        gender = 'Female';
      }
    });
    DateTime date2 = DateTime.now();
    DateTime lastDate = date2.subtract(Duration(
      days: 5840,
    ));
    String formattedDate = DateFormat('dd-MMM-yyyy').format(lastDate);
    setState(() {
      dateHint = formattedDate;
      selectedDate = lastDate;
      lastDatePicking = lastDate;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      return Container(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  initialValue: firstName,
                  decoration: const InputDecoration(
                    labelText: 'First Name',
                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue)),
                  ),
                  validator: (String value) {
                    if (value.trim().isEmpty) {
                      return 'First name is required!';
                    }
                  },
                  onSaved: (String value) {
                    firstName = value;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  initialValue: lastName,
                  decoration: const InputDecoration(
                    labelText: 'Last Name',
                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue)),
                  ),
                  validator: (String value) {
                    if (value.trim().isEmpty) {
                      return 'Last name is required!';
                    }
                  },
                  onSaved: (String value) {
                    lastName = value;
                  },
                ),
                const SizedBox(height: 16.0),
                GestureDetector(
                  onTap: () async {
                    _selectDate(context);
                  },
                  child: Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 10),
                    //   margin: EdgeInsets.symmetric(horizontal: 20),
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          dob,
                          style: TextStyle(fontSize: 18),
                        ),
                        Container(
                          child: IconButton(
                            icon: Icon(
                              Icons.calendar_today,
                              color: Theme.of(context).backgroundColor,
                            ),
                            onPressed: () {
                              _selectDate(context);
                            },
                          ),
                        )
                      ],
                    ),
                    decoration: BoxDecoration(
                        border: Border.all(width: 1.0, color: Colors.grey),
                        borderRadius: BorderRadius.circular(5)),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                ScopedModelDescendant<MainModel>(builder:
                    (BuildContext context, Widget child, MainModel model) {
                  return model.isLoading
                      ? Center(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircularProgressIndicator(),
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  "Please Wait...",
                                  style: TextStyle(
                                      color: Theme.of(context).backgroundColor),
                                )
                              ]),
                        )
                      : Container();
                }),
                Container(
                    padding: EdgeInsets.only(top: 50, bottom: 50),
                    alignment: Alignment.center,
                    child: Column(
                      children: <Widget>[
                        ScopedModelDescendant<MainModel>(builder:
                            (BuildContext context, Widget child,
                                MainModel model) {
                          return SizedBox(
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            child: RaisedButton(
                              child: Text(
                                'CHANGE MY PASSWORD',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 18),
                              ),
                              onPressed: () {
                                _submitPassword(model.forgotPassword);
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
                            (BuildContext context, Widget child,
                                MainModel model) {
                          return SizedBox(
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            child: RaisedButton(
                              child: Text(
                                'SAVE',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 18),
                              ),
                              onPressed: () {
                                _submit(model.update);
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
          ));
    });
  }

  void _submitPassword(Function forgotPassword) async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    Map<String, dynamic> successInformation;
    successInformation = await forgotPassword(userEmail);
    if (successInformation['success']) {
      if (successInformation['message'] == 'Password sent to email') {
        Navigator.push<dynamic>(
          context,
          MaterialPageRoute<dynamic>(
            builder: (context) => ForgotPasswordSuccessScreen(userEmail),
          ),
        );
      } else {
        showDialog<dynamic>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('En Error Occured'),
              content: Text(successInformation['message']),
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
    } else
      showDialog<dynamic>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('En Error Occured'),
            content: Text("Some thing went wrong"),
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

  void _submit(Function update) async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    setState(() {
      loading = true;
    });

    Map<String, dynamic> successInformation;
    successInformation = await update(
      firstName,
      lastName,
      dob,
      userId,
    );
    if (successInformation['success']) {
      Navigator.pushNamed(context, '/profilePage');
    } else {
      showDialog<dynamic>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('En Error Occured'),
            content: Text(successInformation['message']),
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
    if (successInformation['message'] == false) {
      showDialog<dynamic>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('En Error Occured'),
            content: Text("Some thing went wrong"),
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

  Future<Null> _selectDate(BuildContext context) async {
    DateTime picked = await showDatePicker(
        context: context,
        initialDate: new DateTime(DateTime.now().year - 16),
        firstDate: DateTime(1950, 8),
        lastDate: lastDatePicking);
    setState(() {
      selectedDate = picked == null ?new DateTime(DateTime.now().year - 16): picked ;
      String formattedDate = DateFormat('dd-MMM-yyyy').format(picked);
      print(picked);
      dateHint = DateFormat('dd-MMM-yyyy').format(new DateTime(DateTime.now().year - 16));
      dob = formattedDate;
    });
  }


}
