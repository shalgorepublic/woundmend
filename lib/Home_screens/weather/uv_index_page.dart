import 'dart:convert';

import 'package:derm_pro/models/uv.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

class UvIndexPage extends StatefulWidget {
  final currentLocation;

  UvIndexPage(this.currentLocation);

  @override
  _UvIndexPageState createState() => _UvIndexPageState();
}

class _UvIndexPageState extends State<UvIndexPage> {
  bool _isLoading = false;
  Map<String , dynamic> finalUvData;
  UvIndex finalUvIndexData;
  String precaution;
  String risk;
  String first =
      'Wear sunglasses on bright days.If you burn easily, cover up and use broad spectrum SPF 30+ sunscreen.';
  String second =
      'Stay in shade near midday when the sun is strongest.If outdoors, wear protective clothing, a wide-brimmed hat, and UV-blocking sunglasses.';
  String third = 'Reduce time in the sun between 10 a.m. and 4 p.m.If outdoors, seek shade and wear protective clothing, a wide-brimmed hat, and UV-blocking sunglasses.';
  String fourth = 'Minimize sun exposure between 10 a.m. and 4 p.m.If outdoors, seek shade and wear protective clothing, a wide-brimmed hat, and UV-blocking sunglasses.';
  String fifth = 'Try to avoid sun exposure between 10 a.m. and 4 p.m.If outdoors, seek shade and wear protective clothing, a wide-brimmed hat, and UV-blocking sunglasses.';
  String shadowRules = 'If your shadow is taller than you are (in the early morning and late afternoon), your UV exposure is likely to be lower.If your shadow is shorter than you are (around midday), you are being exposed to higher levels of UV radiation. Seek shade and protect your skin and eyes.';

  @override
  void initState() {
    super.initState();
    getUV(widget.currentLocation['lat'] , widget.currentLocation['lng']);
  }

  Future<Map<double , dynamic>> getUV(double lat , double long) async {
    setState(() {
      _isLoading = true;
    });
    http.Response response;
    String token = '78d6f127d96a75f5a213c4a53e791903';
    try {
      final Map<String , dynamic> uvData = {'lat': lat , 'lng': long};
      print("check uv data");
      print(uvData);
      response = await http.get(
          'https://api.openuv.io/api/v1/uv?lat=$lat&lng=$long' ,
          headers: {'x-access-token': token});
      final Map<String , dynamic> responseData = json.decode(response.body);
      if (responseData != null) {
        if (responseData['result'] != null) {
          setState(() {
            final Map<String , dynamic> finalData = responseData['result'];
            print(finalData['uv']);
            _isLoading = false;
            finalUvIndexData =
                UvIndex(uvIndex: finalData['uv'] , time: finalData['uv_time']);
            print(finalUvIndexData.uvIndex);
            print(finalUvIndexData.time);
            if (finalUvIndexData.uvIndex >= 0 &&
                finalUvIndexData.uvIndex <= 2) {
              risk = 'Low';
              precaution = first;
            }
            if (finalUvIndexData.uvIndex > 2 &&
                finalUvIndexData.uvIndex <= 5) {
              risk = 'Moderate';
              precaution = second;
            }
            if (finalUvIndexData.uvIndex > 5 &&
                finalUvIndexData.uvIndex <= 7) {
              risk = 'High';
              precaution = third;
            }
            if (finalUvIndexData.uvIndex > 7 &&
                finalUvIndexData.uvIndex <= 10) {
              risk = 'Very High';
              precaution = fourth;
            }
            if (finalUvIndexData.uvIndex > 10) {
              risk = 'Extreme';
              precaution = fifth;
            }
          });
        } else {
          setState(() {
            _isLoading =false;
          });
          print("An error has occoured");

        }
      }
    } catch (error) {
      setState(() {
        _isLoading = false;
        print("Error");
        showDialog<dynamic>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('En Error Occured'),
              content: Text("Some thing went wrong"),
              actions: <Widget>[
                FlatButton(
                  child: Text('Okey'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          },
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("UV Index"),
        actions: [
          Container(padding: EdgeInsets.only(right: 15) , child:
          GestureDetector(child: Container(
            padding: EdgeInsets.only(right: 5) , child: Icon(Icons.refresh) ,) ,
            onTap: () {
              getUV(widget.currentLocation['lat'] , widget.currentLocation['lng']);
            } ,)
          )

        ] ,) ,
      body: Center(
        child: ListView(
          children: <Widget>[
            _isLoading
                ? Center(child:
            Container(padding:EdgeInsets.only(top: 200),alignment:Alignment.center,child:
            CircularProgressIndicator()))
                : Container(
              child: Column(
                children: <Widget>[
                  Container(
                    padding:
                    EdgeInsets.only(left: 40 , right: 40 , top: 20) ,
                    child: Center(
                      //child: Text("helo"),
                      child: Image.asset(
                        'assets/sun.png' ,
                        width: 150 ,
                        height: 100 ,
                      ) ,
                    ) ,
                  ) ,
                  finalUvIndexData != null
                      ? Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(top: 15) ,
                        child: Text(
                          risk ,
                          style: TextStyle(
                              fontFamily: 'Bold' ,
                              fontSize: 22 ,
                              color: Theme
                                  .of(context)
                                  .textSelectionColor) ,
                        ) ,
                      ) ,
                      SizedBox(height: 20 ,) ,
                      Container(
                        padding: EdgeInsets.only(left: 20) ,
                        alignment: Alignment.centerLeft ,
                        child: Text("Latest Result" , style: TextStyle(
                            fontFamily: 'Bold' , color: Theme
                            .of(context)
                            .highlightColor , fontSize: 18) ,) ,
                      ) ,
                      Container(
                        padding: EdgeInsets.only(left: 20 , top: 5) ,
                        alignment: Alignment.centerLeft ,
                        child: Text(finalUvIndexData.time , style: TextStyle(
                            fontSize: 16 , color: Theme
                            .of(context)
                            .highlightColor) ,) ,
                      ) ,
                      SizedBox(height: 20 ,) ,
                      Container(
                        padding: EdgeInsets.only(left: 20) ,
                        alignment: Alignment.centerLeft ,
                        child: Text("Advice" , style: TextStyle(
                            fontFamily: 'Bold' , color: Theme
                            .of(context)
                            .highlightColor , fontSize: 18) ,) ,
                      ) ,
                      Container(
                        padding: EdgeInsets.only(
                            left: 20 , right: 20 , top: 5) ,
                        alignment: Alignment.centerLeft ,
                        child: Text(precaution , style: TextStyle(color: Theme
                            .of(context)
                            .highlightColor , fontSize: 16) ,) ,
                      ) ,
                      SizedBox(height: 20 ,) ,
                      Container(
                        padding: EdgeInsets.only(left: 20) ,
                        alignment: Alignment.centerLeft ,
                        child: Text("Shadow Rules" , style: TextStyle(
                            fontFamily: 'Bold' , color: Theme
                            .of(context)
                            .highlightColor , fontSize: 18) ,) ,
                      ) ,
                      Container(
                        padding: EdgeInsets.only(
                            left: 20 , right: 20 , top: 5) ,
                        alignment: Alignment.centerLeft ,
                        child: Text(shadowRules , style: TextStyle(color: Theme
                            .of(context)
                            .highlightColor , fontSize: 16) ,) ,
                      )
                    ] ,
                  )
                      : Container()
                ] ,
              ) ,
            )
          ] ,
        ) ,
      ) ,
    );
  }
}
