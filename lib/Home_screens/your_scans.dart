import 'package:derm_pro/Home_screens/article_detail.dart';
import 'package:derm_pro/Home_screens/inbox_page.dart';
import 'package:derm_pro/Home_screens/my_tickets.dart';
import 'package:derm_pro/Home_screens/setting/ui_elements/colors.dart';
import 'package:derm_pro/Home_screens/support.dart';
import 'package:derm_pro/Home_screens/ui_elements_home/drawer.dart';
import 'package:derm_pro/scoped_models/main.dart';
import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Data {
  int firstIndex;
  int secondIndex;

  Data({
    this.firstIndex,
    this.secondIndex,
  });
}

class YourScans extends StatefulWidget {
  final MainModel _model;

  YourScans(this._model);

  @override
  _YourScansState createState() => _YourScansState();
}

class _YourScansState extends State<YourScans> {
  static const String routeName = '/LibraryScreen';

  bool flag = true;
  int indexValue;
  ScrollController _rrectController = ScrollController();

  @override
  void initState() {
    getData();
  }

  void getData() async {
    print("helo Your scans request Results");
    Map<String, dynamic> Result = await widget._model.fetchQueriesSpots();

    if (Result['success'] == false) {
      _showDialogue(context, Result['message']);
    }
    print('helo${Result}');
  }

  Future<void> _showDialogue(BuildContext context, String message) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('En Error Occured'),
            content: Text(message),
            actions: <Widget>[
              FlatButton(
                child: Text('Okey'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  Future<void> _showImageDialogue(BuildContext context, data) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: Container(
                alignment: Alignment.center,
                child: Text('Location of mole:${data.querySpotPlace}')),
            content: Container(
                color: Colors.transparent,
                // height: MediaQuery.of(context).size.height / 2,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    // Image.network(),
                    CachedNetworkImage(
                      imageUrl:
                          'http://dermpro.herokuapp.com${data.images.first}',
                      placeholder: (context, url) =>
                          new CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          new Icon(Icons.error),
                    ),
                    Container(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        'Created At: ${data.createdAt ?? 'Not available'}',
                        style: TextStyle(color: Theme.of(context).dividerColor),
                      ),
                    )
                  ],
                )),
          );
        });
  }

  bool newMsg(int id) {
    for (int i = 0; i < widget._model.readFlagObjects.length; i++) {
      if (widget._model.readFlagObjects[i].id == id &&
          widget._model.readFlagObjects[i].flag == true) {
        return true;
      }
    }
    return false;
  }

  void undoreadmsg(int id) {
    print("iddddddddddddddddddddddddddddddd");
    print(id);
    for (int i = 0; i < widget._model.readFlagObjects.length; i++) {
      print(widget._model.readFlagObjects[i].id);
      if (widget._model.readFlagObjects[i].id == id) {
        widget._model.readFlagObjects[i].flag = false;
        widget._model.justtosetstate();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerBuilder(),
      appBar: AppBar(
        title: Text("Your Scans"),
        centerTitle: true,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        /* actions: [
          Container(
              padding: EdgeInsets.only(right: 15),
              child: Row(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(right: 5),
                    child: Icon(Icons.search),
                  ),
                  ScopedModelDescendant<MainModel>(builder:
                      (BuildContext context, Widget child, MainModel model) {
                    return GestureDetector(
                      child: Icon(Icons.dehaze),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute<dynamic>(
                            builder: (BuildContext context) =>
                                MyTicketsScreen(model)));
                      },
                    );
                  })
                ],
              ))
        ],*/
      ),
      body: ScopedModelDescendant<MainModel>(
        builder: (context, child, model) => model.allQueries == null
            ? Center(child: CircularProgressIndicator())
            : Container(
                padding: EdgeInsets.only(top: 10),
                height: MediaQuery.of(context).size.height,
                child: DraggableScrollbar.rrect(
                  alwaysVisibleScrollThumb: true,
                  backgroundColor: Theme.of(context).backgroundColor,
                  controller: _rrectController,
                  //  labelTextBuilder: (offset) => Text("${offset.floor()}"),
                  child: ListView(
                    controller: _rrectController,
                    children: model.allQueries
                        .map((data) => Container(
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    padding:
                                        EdgeInsets.only(left: 15, right: 15),
                                    child: FlatButton(
                                      child: Row(
                                        children: <Widget>[
                                          GestureDetector(
                                            child: Material(
                                              child: data.images.first != null
                                                  ? CachedNetworkImage(
                                                      placeholder:
                                                          (context, url) =>
                                                              Container(
                                                        child:
                                                            CircularProgressIndicator(
                                                          strokeWidth: 3.0,
                                                          valueColor:
                                                              AlwaysStoppedAnimation<
                                                                      Color>(
                                                                  themeColor),
                                                        ),
                                                        width: 60.0,
                                                        height: 60.0,
                                                        padding: EdgeInsets.all(
                                                            15.0),
                                                      ),
                                                      imageUrl:
                                                          "http://dermpro.herokuapp.com${data.images.first}",
                                                      width: 60.0,
                                                      height: 60.0,
                                                      fit: BoxFit.cover,
                                                    )
                                                  : Icon(
                                                      Icons.account_circle,
                                                      size: 50.0,
                                                      color: greyColor,
                                                    ),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(25.0)),
                                              clipBehavior: Clip.hardEdge,
                                            ),
                                            onTap: () {
                                              print("press me");
                                              _showImageDialogue(context, data);
                                            },
                                          ),
                                          Flexible(
                                            child: GestureDetector(
                                              child: Container(padding: EdgeInsets.only(top:15),
                                                child: Column(
                                                  children: <Widget>[
                                                    Row(
                                                      children: <Widget>[
                                                        Container(
                                                          child: Text(
                                                            'Location of mole:${data.querySpotPlace}',
                                                            style: TextStyle(
                                                                color:
                                                                    primaryColor,fontSize: 12),
                                                          ),
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          margin: EdgeInsets
                                                              .fromLTRB(
                                                                  10.0,
                                                                  0.0,
                                                                  0.0,
                                                                  5.0),
                                                        ),
                                                      ],
                                                    ),
                                                    Container(
                                                      child: Text(
                                                        'Created At: ${data.createdAt ?? 'Not available'}',
                                                        style: TextStyle(
                                                            color: Theme.of(
                                                                    context)
                                                                .dividerColor),
                                                      ),
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      margin:
                                                          EdgeInsets.fromLTRB(
                                                              10.0,
                                                              0.0,
                                                              0.0,
                                                              0.0),
                                                    ),
                                                    Container(alignment: Alignment.centerRight,
                                                      child: newMsg(data.id)
                                                          ? /*Container(child: Text("n"),)*/
                                                      ClipOval(
                                                              child: Container(
                                                                  height: 15,
                                                                  width: 15,
                                                                  color: Colors
                                                                      .yellowAccent,
                                                                  child:
                                                                      Text("")),
                                                            )
                                                          : Text(""),
                                                    )
                                                  ],
                                                ),
                                                margin:
                                                    EdgeInsets.only(left: 20.0),
                                              ),
                                              onTap: () {
                                                undoreadmsg(data.id);
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        InboxScreen(
                                                            id: data.id,
                                                            model: model),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                      onPressed: () {},
                                      color: greyColor2,
                                      padding: EdgeInsets.fromLTRB(
                                          25.0, 10.0, 25.0, 10.0),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                    ),
                                    margin: EdgeInsets.only(
                                        bottom: 10.0, left: 5.0, right: 5.0),
                                  )
                                ],
                              ),
                            ))
                        .toList(),
                  ),
                ),
              ),
      ),
      //  bottomNavigationBar: _buildBottomBar(BuildContext),
    );
  }
}
