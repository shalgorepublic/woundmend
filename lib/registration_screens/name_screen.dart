import 'package:derm_pro/registration_screens/last_name_screen.dart';
import 'package:derm_pro/ui_elements/app_bar_line.dart';
import 'package:flutter/material.dart';
import './email_page.dart';


class NameScreen extends StatefulWidget {
  @override
  _NameScreenState createState() => _NameScreenState();
}

class _NameScreenState extends State<NameScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _firstName = null;
  void _submitForm() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();

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
                            "Enter Your First Name?",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                //letterSpacing: 1.0,
                                fontSize: 16,
                                fontFamily: 'Bold',
                                color: Theme.of(context).backgroundColor),
                          ),
                        ),
                        Container(
                          width: 50,
                          height: 2,
                          color: Theme.of(context).backgroundColor,
                        ),
                  Form(
                    key: _formKey,
                    child:
                        Container(
                            margin: const EdgeInsets.only(right: 10, left: 10),
                            padding: EdgeInsets.only(bottom: 20, top: 20),
                            child: TextFormField(
                              decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(4)),
                                    borderSide: BorderSide(
                                        width: 1,
                                        color: Theme.of(context).backgroundColor),
                                  ),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide()),
                                  labelText: 'First Name',
                                  filled: true,
                                  fillColor: Colors.white),
                              keyboardType: TextInputType.text,
                              validator: (String value) {
                                if (value.isEmpty ||
                                    // ignore: missing_return
                                    !RegExp(r'^[a-z A-Z,1-9.\-]+$')
                                        .hasMatch(value)) {
                                  // ignore: missing_return, missing_return
                                  return 'Please enter a valid name';
                                }
                              },
                              onSaved: (String value) {
                                _firstName = value;
                              },
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
                          onPressed: () {
                            _submitForm();
                            if(_formKey.currentState.validate()) {
                              Navigator.push<dynamic>(
                                context ,
                                MaterialPageRoute<dynamic>(
                                    builder: (context) => LastNameScreen(_firstName)) ,
                              );
                            }
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 150,),
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
                          child: Text('LOG IN',style: TextStyle( fontWeight: FontWeight.bold ,
                              fontSize: 18 ),),
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
