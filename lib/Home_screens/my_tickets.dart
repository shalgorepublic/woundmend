import 'package:derm_pro/Home_screens/support.dart';
import 'package:derm_pro/scoped_models/main.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class MyTicketsScreen extends StatefulWidget {
  final model;

  MyTicketsScreen(this.model);

  @override
  _MyTicketsScreenState createState() => _MyTicketsScreenState();
}

class _MyTicketsScreenState extends State<MyTicketsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.model.fetchAllTickets();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My tickets"),
        actions: [
          Container(
              padding: EdgeInsets.only(right: 15),
              child: GestureDetector(
                child: Container(
                  padding: EdgeInsets.only(right: 5),
                  child: Icon(Icons.add),
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/SupportPage');
                },
              ))
        ],
      ),
      body: Container(
          padding: EdgeInsets.all(20),
          child: ListView(
            children: <Widget>[
              ScopedModelDescendant<MainModel>(builder:
                  (BuildContext context, Widget child, MainModel model) {
                return model.fetchTicketsLoading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : model.allTickets != null ?
                Container(padding: EdgeInsets.only(bottom: 0.0),
                    height:MediaQuery.of(context).size.height,child:
                ListView.builder(
                        itemCount: model.allTickets.length,
                        itemBuilder: (BuildContext ctxt, int index) {
                          return Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                    child: Text(
                                  model.allTickets[index].title != null ?
                                  model.allTickets[index].title:'null topic',
                                  textDirection: TextDirection.ltr,
                                  style: TextStyle(color: Colors.black),
                                )),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                    child: Text(
                                  model.allTickets[index].createdAt.toIso8601String(),
                                  style: TextStyle(
                                      color: Theme.of(context).highlightColor),
                                ))
                              ],
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: 20.0, horizontal: 20.0),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                    width: 1.0, color: Colors.black54),
                              ),
                              color: Colors.white,
                            ),
                          );
                        })): Container(child: Text("no tickets"),);
              }),
            ],
          )),
    );
  }
}
