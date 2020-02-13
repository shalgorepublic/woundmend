import 'package:derm_pro/registration_screens/dob_screen.dart';
import 'package:derm_pro/ui_elements/app_bar_line.dart';
import 'package:flutter/material.dart';
import './email_page.dart';

class PasswordScreen extends StatefulWidget {
  final Map<String,dynamic> formData;
  PasswordScreen(this.formData);
  @override
  _PasswordScreen createState() => _PasswordScreen(formData);
}

class _PasswordScreen extends State<PasswordScreen> {
  Map<String,dynamic> _formData;
  _PasswordScreen(this._formData);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _password = null;
  void _submitForm() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    _formData = {
      'firstName':_formData['firstName'],
      'lastName':_formData['lastName'],
      'email': _formData['email'],
      'password' : _password
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
                padding: EdgeInsets.only(left: 40 , right: 40 , top: 30) ,
                child: Center(
                  //child: Text("helo"),
                  child: Image.asset(
                    'assets/logo.png' ,
                    width: 300 ,
                    height: 150 ,
                  ) ,
                ) ,
              ) ,
              Container(
                padding: EdgeInsets.all(20) ,
                decoration: new BoxDecoration(
                  //new Color.fromRGBO(255, 0, 0, 0.0),
                  borderRadius: new BorderRadius.all(Radius.circular(50)) ,
                ) ,
                child: Card(
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(top: 20 , bottom: 10,) ,
                          child: Text(
                            "Enter Your Password" ,
                            textAlign: TextAlign.center ,
                            style: TextStyle(
                                fontSize: 16 ,
                                fontFamily: 'Bold' ,
                                color: Theme
                                    .of(context)
                                    .backgroundColor) ,
                          ) ,
                        ) ,
                        Container(
                          width: 50 ,
                          height: 2 ,
                          color: Theme
                              .of(context)
                              .backgroundColor ,
                        ) ,
                  Form(
                    key: _formKey,
                    child:
                        Container(
                           // margin: const EdgeInsets.only(right: 30, left: 30),
                            padding: EdgeInsets.only(bottom: 20 , top: 20,left: 30,right: 30) ,
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
                                      borderSide: BorderSide()) ,
                                  labelText: 'Password' ,
                                  labelStyle: TextStyle(fontSize: 18),
                                  filled: true ,
                                  fillColor: Colors.white) ,
                              validator: (String value) {
                                if (value.isEmpty || value.length < 6) {
                                  // ignore: missing_return, missing_return
                                  return 'Please enter a valid password';
                                }
                              },
                              onSaved: (String value) {
                                _password = value;
                              },

                            )), ),
                      ] ,
                    )) ,
              ) ,
              Container(
                padding: EdgeInsets.only(top: 20) ,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween ,
                  children: <Widget>[
                    GestureDetector(
                        child: Container(
                          height: 50 ,
                          width: 50 ,
                          color: Theme
                              .of(context)
                              .accentColor ,
                          child: IconButton(
                            icon: Icon(
                              Icons.arrow_back_ios ,
                              color: Colors.white ,
                            ) ,
                            onPressed: () {
                              Navigator.pop(context);
                            } ,
                          ) ,
                        )) ,
                    GestureDetector(
                      child:
                      Container(
                          height: 50 ,
                          width: 50 ,
                          color: Theme
                              .of(context)
                              .backgroundColor ,
                            child:
                            IconButton(
                              icon: Icon(
                                Icons.arrow_forward_ios ,
                                color: Colors.white ,
                              ) ,
                            ) ,

                      ) ,
                      onTap: (){
                        _submitForm();
                        if (_formKey.currentState.validate()) {
                        Navigator.push<dynamic>(
                          context,
                          MaterialPageRoute<dynamic>(
                              builder: (context) => DobScreen(_formData)),
                        );
                      }},
                    )
                  ] ,
                ) ,
              ) ,
              /*SizedBox(height: 80,),
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
              )*/

            ])
          ] ,
        ));
  }
}
