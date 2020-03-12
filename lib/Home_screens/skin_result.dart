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
  Color hexToColor(String code) {
    return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }
  String image1;
  String image2;
  int color;
 /* Color color1 = hexToColor("#b74093");
  Color color2 = HexColor("#b74093");
  Color color3 = HexColor("#88b74093");
  Color color1 = HexColor("b74093");
  Color color2 = HexColor("#b74093");
  Color color3 = HexColor("#88b74093");*/
  Map<String, dynamic> firstType = {
    'type': 'Pale White Skin',
    'description': 'Extremely sensitive skin, always burns, never tans',
  };
  Map<String, dynamic> secondType = {
    'type': 'White Skin',
    'description': 'Very sensitive skin, burns easily, tans minimally',
  };
  Map<String, dynamic> thirdType = {
    'type': 'Light Brown Skin',
    'description': 'Sensitive skin, sometimes burns, slowly tans to light brown',
  };
  Map<String, dynamic> fourthType = {
    'type': 'Moderate Brown Skin',
    'description':
        'Mildly sensitive, burns minimally, always tans to moderate brown',
  };
  Map<String, dynamic> fifthType = {
    'type': 'Dark Brown Skin',
    'description': 'Resistant skin, rarely burns, tans well',
  };
  Map<String, dynamic> sixthType = {
    'type': 'Pigmented dark Brown',
    'description': 'Very resistant skin, never burns, deeply pigmented',
  };
  Map<String, dynamic> finalResult;
  @override
  void initState() {
    print("score");
    print(widget.model.totalScore);
    if (widget.model.totalScore >= 0 && widget.model.totalScore <= 6) {
      setState(() {
        finalResult = firstType;
        image1 = 'assets/ninthimage.png';
        image2 = 'assets/firstimage.png';
        print(image2);
        color = 0xFFEFDC62;
        print(color);
//print(10);

      });
    }
    if (widget.model.totalScore >= 7 && widget.model.totalScore <= 13) {
      setState(() {
        finalResult = secondType;
        image1 ='assets/eleventhimage.png';
        image2 = 'assets/twelthimage.png';
        color = 0xFFE9B964;
      });
    }
    if (widget.model.totalScore >= 14 && widget.model.totalScore <= 20) {
      setState(() {
        finalResult = thirdType;
        image1 = 'assets/tenthimage.png';
        image2 = 'assets/secondimage.png';
        color = 0xFFB06639;
      });
    }
    if (widget.model.totalScore >= 21 && widget.model.totalScore <= 27) {
      setState(() {
        finalResult = fourthType;
        image1 = 'assets/thirdimage.png';
        image2 = 'assets/fourthimage.png';
        color = 0xFF8E5029;
      });
    }
    if (widget.model.totalScore >= 28 && widget.model.totalScore <= 34) {
      setState(() {
        finalResult = fifthType;
        image1 = 'assets/fifthimage.png';
        image2 = 'assets/sixthimage.png';
        color = 0xFF793308;
      });
    }
    if (widget.model.totalScore >= 35) {
      setState(() {
        finalResult = sixthType;
        image1 = 'assets/seventhimage.png';
        image2 = 'assets/eightimage.png';
        color = 0xFF351A1D;
      });
    }
    widget.model.finalResult(finalResult['type'],finalResult['description'],widget.model.user.id,widget.model.riskType);
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
                          color: Color(color),
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
    ScopedModelDescendant<MainModel>(
    builder: (context, child, model) =>
           Container(padding:EdgeInsets.only(top:30),alignment:Alignment.center,child: Row(mainAxisAlignment:MainAxisAlignment.center,children: <Widget>[
             Container(
               // padding: EdgeInsets.only(left: 40, right: 40, top: 30),
               child: Center(
                 //child: Text("helo"),
                 child: Image.asset(
                   image1,
                   width: 150,
                   height: 150,
                 ),
               ),
             ),
             Container(
               // padding: EdgeInsets.only(left: 40, right: 40, top: 30),
               child: Center(
                 //child: Text("helo"),
                 child: Image.asset(
                   image2,
                   width: 150,
                   height: 150,
                 ),
               ),
             ),
           ],),))


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
