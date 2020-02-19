import 'dart:convert';

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
  @override
  void initState(){

    super.initState();
    getUV(widget.currentLocation['lat'],widget.currentLocation['lng']);

  }
  Future<Map<double , dynamic>> getUV(double lat,double long) async {
    setState(() {
      _isLoading = true;
    });
    http.Response response;
    String token = '257443ba845cbf3e6305438d51c3e125';
    try {
      final Map<String , dynamic>  uvData ={'lat':lat,'lng':long};
      response = await http.get(
          'https://api.openuv.io/api/v1/uv?lat=$lat&lng=$long',
          headers:{'x-access-token': token}
      );
      print(response.body);
      print("helo shaidadadadadad");
      final Map<String , dynamic> responseData = json.decode(response.body);
      final Map<String , dynamic> finalData = responseData['result'];
      if(responseData['result'].hasData){
        setState(() {
          _isLoading = false;
        });
      }
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("UV Index"),),body: Center(child: Column(children: <Widget>[
     _isLoading ? CircularProgressIndicator():Container(child: Text("helo"),)
    ],),),);
  }
}
