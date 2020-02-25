import 'package:derm_pro/scoped_models/main.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class SkinResultScreen extends StatefulWidget {
  final MainModel model;

  SkinResultScreen(this.model);

  @override
  _SkinResultScreenState createState() => _SkinResultScreenState();
}

class _SkinResultScreenState extends State<SkinResultScreen> {
  Map<String, dynamic> firstType = {
    'type': 'Pale white skin',
    'description': 'Extremely sensitive skin, always burns, never tans'
  };
  Map<String, dynamic> secondType = {
    'type': 'White skin',
    'description': 'Very sensitive skin, burns easily, tans minimally'
  };
  Map<String, dynamic> thirdType = {
    'type': 'Light brown skin',
    'description': 'Sensitive skin, sometimes burns, slowly tans to light brown'
  };
  Map<String, dynamic> fourthType = {
    'type': 'Moderate brown skin',
    'description':
        'Mildly sensitive, burns minimally, always tans to moderate brown'
  };
  Map<String, dynamic> fifthType = {
    'type': 'Dark brown skin',
    'description': 'Resistant skin, rarely burns, tans well'
  };
  Map<String, dynamic> sixthType = {
    'type': 'Deeply pigmented dark brown to black skin',
    'description': 'Very resistant skin, never burns, deeply pigmented'
  };
  Map<String, dynamic> finalResult;

  @override
  void initState() {
    print(widget.model.totalScore);
    if (widget.model.totalScore >= 0 && widget.model.totalScore <= 6) {
      setState(() {
        finalResult = firstType;
      });
    }
    if (widget.model.totalScore >= 7 && widget.model.totalScore <= 13) {
      setState(() {
        finalResult = secondType;
      });
    }
    if (widget.model.totalScore >= 14 && widget.model.totalScore <= 20) {
      setState(() {
        finalResult = thirdType;
      });
    }
    if (widget.model.totalScore >= 21 && widget.model.totalScore <= 27) {
      setState(() {
        finalResult = fourthType;
      });
    }
    if (widget.model.totalScore >= 28 && widget.model.totalScore <= 34) {
      setState(() {
        finalResult = fifthType;
      });
    }
    if (widget.model.totalScore >= 35) {
      setState(() {
        finalResult = sixthType;
      });
    }
    widget.model.finalResult(finalResult['type'],finalResult['description'],widget.model.user.id);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Skin Type"),
        ),
        body:
        Column(
            children:[
        Expanded(child:
        ListView(
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
                ],
              ),
            ),
            ScopedModelDescendant<MainModel>(
                builder: (context, child, model) => Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(
                    top: 20,
                  ),
                  child: Text(
                    model.finalSkinResult.type,
                    style: TextStyle(fontSize: 22, color: Colors.black54),
                  ),
                )),
            ScopedModelDescendant<MainModel>(
              builder: (context, child, model) =>
            Container(
              padding: EdgeInsets.only(left: 20, right: 20, top: 30),
              child: Text(
                model.finalSkinResult.description,
                style: TextStyle(color: Colors.black54, fontSize: 18),
              ),
            ),),
          ],
        )),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(padding: EdgeInsets.only(top: 20,bottom: 20),
                        alignment: Alignment.bottomCenter,
                        child: SizedBox(
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
                              Navigator.pushReplacementNamed(
                                  context, '/profilePage');
                            },
                          ),
                        ),
                      ),
                      GestureDetector(
                        child: Container(padding:EdgeInsets.only(bottom: 20),
                          alignment: Alignment.center,
                          child: Text(
                            "Retake",
                            style: TextStyle(
                                fontSize: 18,
                                color: Theme.of(context).backgroundColor),
                          ),
                        ),
                        onTap: () {
                          Navigator.pushReplacementNamed(context, '/skinPage');
                        },
                      )
                    ],
                  )) ])
       );
  }
}
