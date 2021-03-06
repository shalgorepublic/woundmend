import 'dart:async';
import 'package:derm_pro/ui_elements/app_bar_line.dart';
import 'package:flutter/material.dart';
import '../registration_screens/phone_number_screen.dart';
import 'package:intl/intl.dart';

class DobScreen extends StatefulWidget {
  final Map<String,dynamic> formData;
  DobScreen(this.formData);
  @override
  _DobScreen createState() => _DobScreen(formData);
}

class _DobScreen extends State<DobScreen> {
  Map<String,dynamic> _formData;
  _DobScreen(this._formData);
  String dateHint;
  String dob= DateFormat('dd-MMM-yyyy').format(new DateTime(DateTime.now().year - 16));
  DateTime lastDatePicking;
  DateTime selectedDate = DateTime.parse("1970-01-01T11:00:00.000Z");
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  void _submitForm() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    _formData = {
      'firstName':_formData['firstName'],
      'lastName':_formData['lastName'],
      'email': _formData['email'],
      'password' : _formData['password'],
      'date': dateHint
    };
  }
  /*Future<Null> _selectDate(BuildContext context) async {
     DateTime picked = await showDatePicker(
        context: context,
        initialDate: new DateTime(DateTime.now().year - 16),
        firstDate: DateTime(1950, 8),
        lastDate: lastDatePicking);
    setState(() {
      selectedDate = picked == null ?new DateTime(DateTime.now().year - 16): picked ;
      String formattedDate = DateFormat('dd-MMM-yyyy').format(picked);
      print(picked);
      dateHint =  DateFormat('dd-MMM-yyyy').format(new DateTime(DateTime.now().year - 16));
    });
  }*/
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
  @override
  void initState() {
    // TODO: implement initState
    DateTime date2 = DateTime.now();
    DateTime lastDate = date2.subtract(Duration(days: 5840,));
    String formattedDate = DateFormat('dd-MMM-yyyy').format(lastDate);
    setState(() {
      dateHint =  DateFormat('dd-MMM-yyyy').format(new DateTime(DateTime.now().year - 16));
      selectedDate = lastDate;
      lastDatePicking = lastDate;
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: <Widget>[
        Column(children: <Widget>[
          AppBarLine(),
          Container(
            padding: EdgeInsets.only(left: 40, right: 40, top: 30),
            child: Center(
              //child: Text("helo"),
              child: Image.asset(
                'assets/logo.png',
                width: 300,
                height: 150,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            decoration: new BoxDecoration(
              //new Color.fromRGBO(255, 0, 0, 0.0),
              borderRadius: new BorderRadius.all(Radius.circular(50)),
            ),
            child: Card(
                child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 20, bottom: 10),
                  child: Text(
                    "Enter Your Date of Birth",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Bold',
                        color: Theme.of(context).accentColor),
                  ),
                ),
                Container(
                  width: 50,
                  height: 2,
                  color: Theme.of(context).accentColor,
                ),
            Form(
                key: _formKey,
                child:
                Container(
                    // margin: const EdgeInsets.only(right: 10, left: 10),
                    padding: EdgeInsets.only(
                        bottom: 40, top: 20, right: 20, left: 20),
                    child: Column(
                      children: <Widget>[
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
                                      color: Theme.of(context).accentColor,

                                    ),
                                    onPressed: () {
                                      _selectDate(context);
                                    },
                                  ),
                                )
                              ],
                            ),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(width: 1.0, color: Colors.grey),
                                borderRadius: BorderRadius.circular(5)),
                          ),
                        ),
                        Container(
                            padding: EdgeInsets.only(top: 3),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  "You must be over the age of 16 to use ",
                                  style: TextStyle(
                                      color: Theme.of(context).backgroundColor,
                                      fontSize: 12),
                                ),
                                Text(
                                  "DERM PRO",
                                  style: TextStyle(
                                      color: Theme.of(context).accentColor,
                                      fontSize: 12),
                                )
                              ],
                            )),
                      ],
                    )),),
              ],
            )),
          ),
          Container(
            padding: EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                GestureDetector(
                    child: Container(
                  height: 50,
                  width: 50,
                  color: Theme.of(context).accentColor,
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                )),
                GestureDetector(
                    child: Container(
                      height: 50,
                      width: 50,
                      color: Theme.of(context).backgroundColor,
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    onTap: () {
                      _submitForm();
                      if (_formKey.currentState.validate()) {
                        Navigator.push<dynamic>(
                          context ,
                          MaterialPageRoute<dynamic>(
                              builder: (context) => PhoneScreen(_formData)) ,
                        );
                      }
                    })
              ],
            ),
          ),
          SizedBox(
            height: 60,
          ),
          /*Container(
            width: 250,
            height: 40,
            child: RaisedButton(
              elevation: 4,
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              color: Theme.of(context).accentColor,
              child: FittedBox(
                child: Row(
                  children: <Widget>[
                    Text(
                      '- - - - - - -',
                      style: TextStyle(fontSize: 12),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 60),
                      child: Text(
                        'LOG IN',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                    Text(
                      '- - - - - - -',
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
              textColor: Colors.white,
              onPressed: () {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('/emailPage',
                    ModalRoute.withName("/signup"));
              },
            ),
          )*/
        ])
      ],
    ));
  }
}
