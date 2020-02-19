import 'package:derm_pro/Home_screens/ui_elements_home/drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LibraryScreen extends StatefulWidget {
  static const String routeName = '/LibraryScreen';

  @override
  _LibraryScreenState createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  List<String> items = [
    'Why should i only take photo of my own skin?',
    'Complaint Procedure',
    'Why should i only take photo of my own skin?',
    'Complaint Procedure',
    'Why should i only take photo of my own skin?',
    'Complaint Procedure',
  ];
  List<String> secondItems = [
    'Why should i only take photo of my own skin?',
    'Complaint Procedure',
    'Why should i only take photo of my own skin?',
    'Complaint Procedure',
    'Why should i only take photo of my own skin?',
    'Complaint Procedure',
  ];
  bool flag = true;
  bool secondFlag = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerBuilder(),
      appBar: AppBar(title: Text("Support"),centerTitle: true,leading: new IconButton(
        icon: new Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
        actions: [
          Container(padding:EdgeInsets.only(right: 15),child: Row(children: <Widget>[
            Container(padding:EdgeInsets.only(right: 5),child:Icon(Icons.search),),
            Icon(Icons.dehaze),
          ],))

        ],),
      body: Container(
        color: Colors.white,
        child: ListView(
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(top: 20, left: 20, bottom: 20),
              color: Theme.of(context).hoverColor,
              child: Container(
                  child: Text(
                "FAQ & SKIN VISION",
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
            ),
            Container(
                height: flag ? 100 : 220,
                child: new ListView.builder(
                    itemCount: flag ? 2 : 4,
                    itemBuilder: (BuildContext ctxt, int index) {
                      return Container(
                          padding: EdgeInsets.only(left: 5),
                          child: ListTile(
                              title: Text(
                            items[index],
                            style: TextStyle(fontSize: 14),
                          )));
                    })),
            flag ?
            Container(
                alignment: Alignment.center,
                child: InkWell(
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(top: 10,bottom: 10),
                    child: Text(
                      "MORE",
                      style: TextStyle(
                          color: Theme.of(context).accentColor, fontSize: 14),
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      flag = !flag;
                    });
                  },
                )):Container(),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(top: 20, left: 20, bottom: 20),
              color: Theme.of(context).hoverColor,
              child: Container(
                  child: Text(
                "THE ASSESSMENT",
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
            ),
            Container(
                height: secondFlag ? 100 : 220,
                child: new ListView.builder(
                    itemCount: secondFlag ? 2 : 4,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                          padding: EdgeInsets.only(left: 5),
                          child: ListTile(
                              title: Text(
                                secondItems[index],
                                style: TextStyle(fontSize: 14),
                              )));
                    })),
            secondFlag ?
            Container(
                alignment: Alignment.center,
                child: InkWell(
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(top: 10,bottom: 10),
                    child: Text(
                      "MORE",
                      style: TextStyle(
                          color: Theme.of(context).accentColor, fontSize: 14),
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      secondFlag = !secondFlag;
                    });
                  },
                )):Container(),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(top: 10),
        child: SizedBox(
          height: 60,
          width: 60,
          child: FloatingActionButton(
            backgroundColor: Colors.blue,
            elevation: 0,
            onPressed: () {
              //  imagepicker();
            },
            child: Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 4),
                  shape: BoxShape.circle,
                  color: Theme.of(context).backgroundColor),
              child: Icon(
                Icons.add,
                size: 30,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 60,
          color: Theme.of(context).backgroundColor,
          child: Column(children: <Widget>[
            Row(
              children: <Widget>[
                Container(margin: EdgeInsets.only(top: 20),
                  height: 10,
                  color:Theme.of(context).backgroundColor,
                  width: MediaQuery.of(context).size.width / 1.35,
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 1,
                        color: Colors.white,
                        width: MediaQuery.of(context).size.width / 1.25,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 5),
                  height: 10,
                  color: Theme.of(context).backgroundColor,
                  width: MediaQuery.of(context).size.width / 1.9,
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 1,
                        color: Colors.white,
                        width: MediaQuery.of(context).size.width / 1.25,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],)

        ),
      ),
    );
  }
}
