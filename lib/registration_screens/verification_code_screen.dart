import 'package:derm_pro/ui_elements/app_bar_line.dart';
import 'package:flutter/material.dart';
import 'package:derm_pro/Profile_screen/profile_screen.dart';

class VarificationScreen extends StatefulWidget {
  final Map<String, dynamic> formData;

  VarificationScreen(this.formData);

  @override
  _VarificationScreen createState() => _VarificationScreen(formData);
}

class _VarificationScreen extends State<VarificationScreen> {
  Map<String, dynamic> _formData;

  _VarificationScreen(this._formData);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _verifycode = null;

  void _submitForm() async {
    print("helo verifiy code");
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    _formData = {
      'firstName': _formData['firstName'],
      'lastName': _formData['lastName'],
      'email': _formData['email'],
      'password': _formData['password'],
      'dob': _formData['dob'],
      'phoneNumber': _formData['phoneNumber'],
      'verifyCode': _verifycode
    };
    print(_formData);
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
                  padding: EdgeInsets.only(
                    top: 20,
                    bottom: 10,
                  ),
                  child: Text(
                    "ENTER VERIFICATION CODE",
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
                    child: Container(
                        padding: EdgeInsets.only(
                            bottom: 30, top: 30, right: 30, left: 30),
                        child: TextFormField(
                          textAlignVertical: TextAlignVertical.center,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue)),
                              labelText: 'Verification Code',
                              labelStyle: TextStyle(fontSize: 18),
                              filled: true,
                              fillColor: Colors.white),
                          keyboardType: TextInputType.number,
                          validator: (String value) {
                            if (value.isEmpty || value.length <= 3 || value.length > 4) {
                              // ignore: missing_return, missing_return
                              return 'Please enter a 4 digit Code';
                            }
                          },
                          onSaved: (String value) {
                            _verifycode = value;
                          },
                        ))),
              ],
            )),
          ),
          SizedBox(
            height: 30,
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
                    width: 130,
                    color: Theme.of(context).backgroundColor,
                    child: Row(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            "SUBMIT",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.white),
                          ),
                        ),
                        IconButton(
                            icon: Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                            ),
                            onPressed: () {}),
                      ],
                    ),
                  ),
                  onTap: () {
                    _submitForm();
                    //  Navigator.pushReplacement(
                    //    context, MaterialPageRoute(builder: (BuildContext context) => ProfileScreen()));
                    if (_formKey.currentState.validate()) {
                      Navigator.pushReplacementNamed(context, '/profilePage');
                    }
                  },
                )
              ],
            ),
          ),
        ])
      ],
    ));
  }
}
