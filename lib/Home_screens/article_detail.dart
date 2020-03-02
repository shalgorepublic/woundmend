import 'package:derm_pro/Home_screens/Library.dart';
import 'package:derm_pro/scoped_models/main.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class ArticleDetailScreen extends StatelessWidget {
  final Data data;

  ArticleDetailScreen(this.data);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Detail") ,
        ) ,
        body:
        ScopedModelDescendant<MainModel>(
          builder: (context , child , model) =>
              ListView(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top: 40 , left: 40) ,
                    child: Text(
                      model.allTopics[data.firstIndex]
                          .articles[data.secondIndex].title ,
                      style: TextStyle(
                          fontFamily: 'Bold' ,
                          fontSize: 24 ,
                          color: Theme
                              .of(context)
                              .highlightColor) ,
                    ) ,
                  ) ,
                  Container(
                    padding: EdgeInsets.only(top: 20 , left: 40 , right: 10) ,
                    child: Text(
                      model.allTopics[data.firstIndex]
                          .articles[data.secondIndex].description ,
                      style: TextStyle(
                          fontFamily: 'Reguler' ,
                          fontSize: 15 ,
                          color: Theme
                              .of(context)
                              .highlightColor) ,
                    ) ,
                  ) ,
                  SizedBox(height: 40,),
                  Center(
                    //child: Text("helo"),
                    child: Image.asset(
                      'assets/cancer.jpg',
                      width: 500,
                      height: 250,
                    ),
                  ),
                 /* Center(
                    //child: Text("helo"),
                    child:  Image.network(
                      'http://dermpro.herokuapp.com${model.allTopics[data.firstIndex]
                          .articles[data.secondIndex].images.first}',
                    ),
                  ),*/
                 /* Container(
                      child: model.allTopics[data.firstIndex]
                          .articles[data.secondIndex].images == null
                          ? Text("No image")
                          : Text( model.allTopics[data.firstIndex]
                          .articles[data.secondIndex].images.first) ,)*/


                ] ,
              ) ,)
    );
  }
}
