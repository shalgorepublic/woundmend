import 'package:derm_pro/Home_screens/article_detail.dart';
import 'package:derm_pro/Home_screens/my_tickets.dart';
import 'package:derm_pro/Home_screens/support.dart';
import 'package:derm_pro/Home_screens/ui_elements_home/drawer.dart';
import 'package:derm_pro/scoped_models/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';


class Data {
  int firstIndex;
  int secondIndex;
  Data({this.firstIndex, this.secondIndex,});
}
class LibraryScreen extends StatefulWidget {
  final MainModel _model;

  LibraryScreen(this._model);

  static const String routeName = '/LibraryScreen';

  @override
  _LibraryScreenState createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  bool flag = true;
  int indexValue;

  @override
  void initState() {
    getData();
  }

  void getData() async {
    print("helo shahid");
    Map<String , dynamic> Result = await widget._model.fetchArticles();

    if (Result['success'] == false) {
      _showDialogue(context , Result['message']);
    }
    print(Result);
  }

  Future<void> _showDialogue(BuildContext context , String message) {
    return showDialog(
        context: context ,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('An Error Occurred') ,
            content: Text(message) ,
            actions: <Widget>[
              FlatButton(
                child: Text('Okey') ,
                onPressed: () {
                  Navigator.of(context).pop();
                } ,
              )
            ] ,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    //  drawer: DrawerBuilder() ,
      appBar: AppBar(
        title: Text("FAQ") ,
        centerTitle: true ,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back) ,
          onPressed: () {
            Navigator.pop(context);
          } ,
        ) ,
       /* actions: [
          Container(
              padding: EdgeInsets.only(right: 15) ,
              child: Row(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(right: 5) ,
                    child: Icon(Icons.search) ,
                  ) ,
                  ScopedModelDescendant<MainModel>(builder:
                      (BuildContext context , Widget child , MainModel model) {
                    return GestureDetector(
                      child: Icon(Icons.dehaze) ,
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute<dynamic>(
                            builder: (BuildContext context) =>
                                MyTicketsScreen(model)));
                      } ,
                    );
                  })
                ] ,
              ))
        ] ,*/
      ) ,
      body: Container(color: Colors.white , child: _buildPageContant(context)) ,
      floatingActionButton: Padding(
        padding: EdgeInsets.only(top: 10) ,
        child: SizedBox(
          height: 60 ,
          width: 60 ,
          child: FloatingActionButton(
            backgroundColor: Colors.blue ,
            elevation: 0 ,
            onPressed: () {
              Navigator.pushNamed(context , '/SupportPage');
            } ,
            child: Container(
              height: 70 ,
              width: 70 ,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white , width: 4) ,
                  shape: BoxShape.circle ,
                  color: Theme
                      .of(context)
                      .backgroundColor) ,
              child: Icon(
                Icons.add ,
                size: 30 ,
                color: Colors.white ,
              ) ,
            ) ,
          ) ,
        ) ,
      ) ,
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked ,
      bottomNavigationBar: _buildBottomBar(BuildContext) ,
    );
  }

  Widget _buildPageContant(context) {
    return ScopedModelDescendant<MainModel>(
        builder: (context , child , model) =>
        model.articleLoading == false
            ? model.allTopics != null
            ? Container(
            child:Column(
              children: <Widget>[
                    Expanded(
                child: new ListView.builder(
//                        shrinkWrap: true,
                    itemCount: model.allTopics.length,
                    itemBuilder: (BuildContext ctxt , int indexs) {
                      return Column(children: <Widget>[
                        Container(
                          alignment: Alignment.centerLeft ,
                          padding: EdgeInsets.only(
                              top: 20 , left: 20 , bottom: 20) ,
                          color: Theme
                              .of(context)
                              .hoverColor ,
                          child: Container(
                              child: Text(
                                model.allTopics[indexs].title ,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold) ,
                              )) ,
                        ) ,
                        Container(
                            child: Column(
                              children: <Widget>[
                                Container(
                                  height: 56 *  model.allTopics[indexs]
                                      .articles.length.toDouble() ,
                                  child: Column(
                                    children:
                                    model.allTopics[indexs]
                                        .articles
                                        .map(
                                            (data) =>
                                            Container(
                                              child:InkWell(
                                                child:
                                                ListTile(
                                                  title:
                                                  Text(data.title) ,
                                                ) ,
                                                onTap:
                                                    () {
                                                  print(model
                                                      .allTopics[indexs]
                                                      .articles.indexOf(
                                                      data));
                                                  print(indexs);
                                                  final indexData = Data(firstIndex: indexs,secondIndex:  model.allTopics[indexs].articles.indexOf(data));
                                                  Navigator.push(
                                                    context ,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          ArticleDetailScreen(indexData),
                                                    ) ,
                                                  );
                                                } ,
                                              ) ,
                                            ))
                                        .toList() ,
                                  ) ,
                                )
                              ] ,
                            )),

                      ]);
                    })),
              ],)
            )
            : Container(child: Text("helo"),)
            : Center(child: CircularProgressIndicator()));
  }

  Widget _buildBottomBar(BuildContext) {
    return BottomAppBar(
      child: Container(
          height: 60 ,
          color: Theme
              .of(context)
              .backgroundColor ,
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 20) ,
                    height: 10 ,
                    color: Theme
                        .of(context)
                        .backgroundColor ,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width / 1.35 ,
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 1 ,
                          color: Colors.white ,
                          width: MediaQuery
                              .of(context)
                              .size
                              .width / 1.25 ,
                        ) ,
                      ] ,
                    ) ,
                  ) ,
                ] ,
              ) ,
              Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 5) ,
                    height: 10 ,
                    color: Theme
                        .of(context)
                        .backgroundColor ,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width / 1.9 ,
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 1 ,
                          color: Colors.white ,
                          width: MediaQuery
                              .of(context)
                              .size
                              .width / 1.25 ,
                        ) ,
                      ] ,
                    ) ,
                  ) ,
                ] ,
              ) ,
            ] ,
          )) ,
    );
  }
}
