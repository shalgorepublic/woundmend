import 'package:derm_pro/Home_screens/Library.dart';
import 'package:derm_pro/Home_screens/inbox_page.dart';
import 'package:derm_pro/Home_screens/profile_screen.dart';
import 'package:derm_pro/Home_screens/skin_type_screen.dart';
import 'package:derm_pro/models/auth.dart';
import 'package:derm_pro/registration_screens/signup.dart';
import 'package:flutter/material.dart';
//import 'package:shared_preferences/shared_preferences.dart';
import './registration_screens/email_page.dart';
import './ui_elements/dashed_line.dart';
import 'package:scoped_model/scoped_model.dart';
import './scoped_models/main.dart';


void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final MainModel _model = MainModel();
  bool _isAuthenticated = false;

  Color hexToColor(String code) {
    return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }
  @override
  void initState() {
    _model.autoAuthenticate();
    _model.userSubject.listen((bool isAuthenticated) {
      setState(() {
        _isAuthenticated = isAuthenticated;
        print(_isAuthenticated);
      });
    });
    super.initState();
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScopedModel<MainModel>(
        model: _model,
        child:
      MaterialApp(
      theme: ThemeData(hoverColor: hexToColor('#F9F9F9'),
        backgroundColor: hexToColor('#2BA2D6'),//blue
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
        accentColor: hexToColor('#8CC63F'),//green
        splashColor: Colors.pink,
      ),
     initialRoute: '/',
      routes: {
        '/': (BuildContext context) =>
        _isAuthenticated ?   ProfileScreen(_model):MyHomePage(),
        '/emailPage': (BuildContext context) => EmailPage(),
        '/profilePage': (BuildContext context) =>  ProfileScreen(_model),
        '/signup': (BuildContext context) => SignupScreen(),
        '/library': (BuildContext context) => LibraryScreen(),
        '/inboxScreen': (BuildContext context) => InboxScreen(),
        '/myHomePage': (BuildContext context) => MyHomePage(),
        '/skinPage': (BuildContext context) => SkinType(_model),
      },
    ),);
  }
}



class MyHomePage extends StatelessWidget {
  double screenHeight;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: <Widget>[
        Column(
          children: <Widget>[
            Container(
              padding:
              EdgeInsets.only(left: 40, right: 40, bottom: 30, top: 60),
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
              child: Text(
                'Worried about a skin spot?',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            const MySeparator(color: Colors.blue),
            Container(
              padding:
              EdgeInsets.only(top: 20, bottom: 20, left: 30, right: 30),
              child: Text(
                  '1 in 5 people get skin cancer.Early detection is the key to treating it.',
                  textAlign: TextAlign.center),
            ),
            // SizedBox(height: 10,),
            Container(
              width: 50,
              height: 2,
              color: Colors.blue,
            ),
            // SizedBox(height: 10,),
            Container(
              padding:
              EdgeInsets.only(top: 20, bottom: 40, left: 30, right: 30),
              child: Text(
                  'Check your skin forsign of skin cancer by taking a photowith your smart phone',
                  textAlign: TextAlign.center),
            ),

            SizedBox(
              width: 220.0,
              height: 40.0,
              child: new RaisedButton(
                color: Theme.of(context).backgroundColor,
                shape: new RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                child: new Text(
                  'FIND OUT MORE',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.white),
                ),
                onPressed: () {},
              ),
            ),
            SizedBox(
              height: 40,
            ),
    ScopedModelDescendant<MainModel>(
    builder: (context, child, model) =>
            Container(
              width: 220,
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
                  model.changeMode(AuthMode.Login);
                  Navigator.push<dynamic>(
                    context,
                    MaterialPageRoute<dynamic>(builder: (context) => EmailPage()),
                  );
                },
              ),
            )),
            SizedBox(height: 20,)

          ],
        ),
      ],

      ),
    );
  }
}
