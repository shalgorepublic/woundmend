import 'package:derm_pro/Home_screens/profile_screen.dart';
import 'package:derm_pro/models/auth.dart';
import 'package:derm_pro/scoped_models/main.dart';
import 'package:derm_pro/ui_elements/app_bar_line.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../registration_screens/signup.dart';


class PasswordScreen extends StatefulWidget {
  final String email;
  const PasswordScreen(this.email);

  @override
  _PasswordScreen createState() => _PasswordScreen(email);
}


class _PasswordScreen extends State<PasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Map<String, dynamic> _formData = {
    'email': null,
    'password': null,
  };
  final String emailName;
  _PasswordScreen(this.emailName);
   String _password = null;
   void _submitForm(Function authenticate) async {
     if (!_formKey.currentState.validate()) {
       return;
     }
     _formKey.currentState.save();
     Map<String, dynamic> successInformation;
     successInformation = await authenticate(emailName, _password);
     if(successInformation['success']){
     if (successInformation['data']['data']['success'] == true) {
       Navigator.pushNamed(context, '/profilePage');
     } else {
       showDialog<dynamic>(
         context: context,
         builder: (BuildContext context) {
           return AlertDialog(
             title: Text('En Error Occured'),
             content: Text(successInformation['data']['data']['message']),
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
     else
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
                    "ENTER YOUR PASSWORD",
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
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          textAlignVertical: TextAlignVertical.center,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue)),
                              labelText: 'Password',
                              labelStyle: TextStyle(fontSize: 18),
                              filled: true,
                              fillColor: Colors.white),
                          keyboardType: TextInputType.number,
                          validator: (String value) {
                            if (value.isEmpty || value.length < 6) {
                              // ignore: missing_return, missing_return
                              return 'Please enter a valid password';
                            }
                          },
                          onSaved: (String value) {
                            _password = value;
                          },
                        ),
                        GestureDetector(onTap: (){

                        },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Container(
                                  padding: EdgeInsets.only(top: 5),
                                  child: Text(
                                    "Forgot Password?",
                                    style: TextStyle(
                                        color:
                                            Theme.of(context).backgroundColor),
                                  ))
                            ],
                          ),
                        )
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
      ScopedModelDescendant<MainModel>(
        builder: (context, child, model) =>
                GestureDetector(
                  child: Container(
                      height: 50,
                      width: 120,
                      color: Theme.of(context).backgroundColor,
                      child: Row(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(left: 20),
                            child: Text(
                              "LOGIN",
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
                          ),
                        ],
                      )),
                  onTap: () {
                    model.changeMode(AuthMode.Login);
                    _submitForm(model.authenticate);
                   /* if(_formKey.currentState.validate()) {
                      Navigator.push<dynamic>(
                        context ,
                        MaterialPageRoute<dynamic>(
                          builder: (BuildContext context) => ProfileScreen(),) ,
                      );
                    }*/
                  },
                )),
              ],
            ),
          ),
          SizedBox(height: 130,),
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
                      child: Text('SIGNUP',style: TextStyle( fontWeight: FontWeight.bold ,
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
                    .pushNamedAndRemoveUntil('/signup',
                    ModalRoute.withName("/signup"));
              },
            ),
          )
        ])
      ],
    ));
  }
}
