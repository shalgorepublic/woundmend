import 'package:derm_pro/ui_elements/app_bar_line.dart';
import 'package:flutter/material.dart';
import '../registration_screens/verification_code_screen.dart';
import './email_page.dart';
class PhoneScreen extends StatefulWidget {
  final Map<String,dynamic> formData;
  PhoneScreen(this.formData);
  @override
  _PhoneScreen createState() => _PhoneScreen(formData);
}

class _PhoneScreen extends State<PhoneScreen> {
  Map<String, dynamic> _formData;
  _PhoneScreen(this._formData);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _phoneNumber = null;
  void _submitForm() async {
    print("helo phone number");
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    _formData = {
      'firstName':_formData['firstName'],
      'lastName':_formData['lastName'],
      'email': _formData['email'],
      'password' : _formData['password'],
      'dob' :_formData['date'],
      'phoneNumber': _phoneNumber
    };
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
                            "ENTER YOUR NUMBER",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
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
                           // margin: const EdgeInsets.only(right: 10, left: 10),
                            padding: EdgeInsets.only(bottom: 30, top: 30,left: 30,right: 30),
                            child: Column(
                              children: <Widget>[
                                TextFormField(
                                  textAlignVertical: TextAlignVertical.center,
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.blue)),
                                      labelText: '+61 4 ----',
                                      labelStyle: TextStyle(fontSize: 18),
                                      filled: true,
                                      fillColor: Colors.white),
                                  keyboardType: TextInputType.number,
                                  validator: (String value) {
                                    if (value.isEmpty || value.length < 11) {
                                      // ignore: missing_return, missing_return
                                      return 'Please enter a valid number';
                                    }
                                  },
                                  onSaved: (String value) {
                                    _phoneNumber = value;
                                  },
                                ),
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
                          child:
                          IconButton(
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
                                  builder: (context) => VarificationScreen(_formData)) ,
                            );
                          }
                        }

                    )
                  ],
                ),
              ),
              SizedBox(height: 80,),
              Container(
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
              )
            ])
          ],
        ));
  }
}
