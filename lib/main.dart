import 'package:flutter/material.dart';
import './registration_screens/email_page.dart';
import './ui_elements/dashed_line.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  Color hexToColor(String code) {
    return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(backgroundColor: hexToColor('#2BA2D6'),//blue
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
        accentColor: hexToColor('#8CC63F'),//green
        splashColor: Colors.pink,
      ),
      routes: {
        '/': (BuildContext context) => MyHomePage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double screenHeight;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              padding:
                  EdgeInsets.only(left: 40, right: 40, bottom: 30, top: 80),
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
                  EdgeInsets.only(top: 20, bottom: 20, left: 30, right: 30),
              child: Text(
                  'Check your skin forsign of skin cancer by taking a photowith your smart phone',
                  textAlign: TextAlign.center),
            ),

            SizedBox(
              width: 220.0,
              height: 40.0,
              child: new RaisedButton(
                color: Colors.blue,
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
              height: 10,
            ),
            Container(
              padding: EdgeInsets.only(top: 30),
              child:  SizedBox(
                width: 220.0,
                height: 40.0,
                child: new RaisedButton(
                  color: Colors.blue,
                  shape: new RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  child:  Text(
                    'LOGIN',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.push<dynamic>(
                      context,
                      MaterialPageRoute<dynamic>(builder: (context) => EmailPage()),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
