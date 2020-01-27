import 'package:derm_pro/registration_screens/second_email_page.dart';
import 'package:derm_pro/ui_elements/app_bar_line.dart';
import 'package:flutter/material.dart';
import './email_page.dart';

class LastNameScreen extends StatefulWidget {
  final String firstName;
  const LastNameScreen(this.firstName);

  @override
  _LastNameScreenState createState() => _LastNameScreenState(firstName);
}

class _LastNameScreenState extends State<LastNameScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final String firstname;
  _LastNameScreenState(this.firstname);
  Map<String, dynamic> _formData = {
    'firstname': null,
    'lastName': null,
  };
  String _lastName = null;
  void _submitForm() async {
    print("helo last name");
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    _formData = {
      'firstName':firstname,
      'lastName':_lastName
    };
  }
  @override
  void initState() {
    print(firstname);
    // TODO: implement initState
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
                            "WHAT IS YOUR LAST NAME?",
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
                            margin: const EdgeInsets.only(right: 10, left: 10),
                            padding: EdgeInsets.only(bottom: 20, top: 20),
                            child: TextFormField(
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.blue)),
                                  labelText: 'Last Name',
                                  filled: true,
                                  fillColor: Colors.white),
                              keyboardType: TextInputType.text,
                              validator: (String value) {
                                if (value.isEmpty || value.length < 6 ||  !RegExp(r'^[a-z A-Z,.\-]+$')
                                        .hasMatch(value)) {
                                  // ignore: missing_return, missing_return
                                  return 'Please enter a valid name';
                                }
                              },
                              onSaved: (String value) {
                                _lastName = value;
                              },
                            ))),
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
                                    builder: (context) => SecondEmailPage(_formData)) ,
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
