import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Skin Type"),
        ),
        body: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 50, left: 150, right: 150),
              child: Column(
                children: <Widget>[
                  Container(
                      decoration: new BoxDecoration(
                          color: Colors.brown,
                          borderRadius:
                              new BorderRadius.all(Radius.circular(10))),
                      padding: EdgeInsets.only(top: 30, bottom: 30)),
                  Container(
                    padding: EdgeInsets.only(top: 20),
                    child: Text(
                      "DARK",
                      style: TextStyle(fontSize: 22, color: Colors.black54),
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 20, right: 20, top: 30),
              child: Text(
                "You tan easily and rarely burn,but you are still at risk.Acral lentiginous melanoma, avery aggressive form of the diseease,is more common among darker-skinned people.",
                style: TextStyle(color: Colors.black54, fontSize: 18),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 20, right: 20, top: 30),
              child: Text(
                "You tan easily and rarely burn,but you are still at risk.Acral lentiginous melanoma, avery aggressive form of the diseease,is more common among darker-skinned people.",
                style: TextStyle(color: Colors.black54, fontSize: 18),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 20, right: 20, top: 30),
              child: Text(
                "You tan easily and rarely burn,but you are still at risk.Acral lentiginous melanoma, avery aggressive form of the diseease,is more common among darker-skinned people.",
                style: TextStyle(color: Colors.black54, fontSize: 18),
              ),
            ),
            Container(padding:EdgeInsets.only(left: 40,right: 40,top: 20),child:
            SizedBox(
              width: 220.0,
              height: 40.0,
              child: new RaisedButton(
                color: Theme.of(context).backgroundColor,
                shape: new RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                child: new Text(
                  'DONE',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.white),
                ),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/profilePage');
                },
              ),
            ),),
            GestureDetector(child:
            Container(padding:EdgeInsets.only(top: 20,bottom: 20),alignment: Alignment.center,
              child: Text(
                "Retake",
                style: TextStyle(
                    fontSize: 18, color: Theme.of(context).backgroundColor),
              ),
            ),onTap: (){

              Navigator.pushReplacementNamed(context, '/skinPage');
            },)
          ],
        ));
  }
}
