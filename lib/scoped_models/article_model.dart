import 'dart:async';
import 'dart:convert';
import 'package:derm_pro/models/articles_model.dart';
import 'package:derm_pro/models/skin_question_model.dart';
import 'package:derm_pro/scoped_models/connected_models.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:flutter/material.dart';


class BoolObject {
   bool value;


  BoolObject({
    @required this.value,
  });

}
class ArticleModel extends ConnectedModel {
  List<Topics> _topics;
  bool _articleLoading = false;
  List<BoolObject> _listOfBoolObjects = [];

  List<Topics> get allTopics {
    return _topics;
  }

  List<BoolObject> get allBoolObject {
    return _listOfBoolObjects;
  }

  bool get articleLoading {
    return _articleLoading;
  }

  Future<Map<String, dynamic>> fetchArticles() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final String token = prefs.get('token');
    _articleLoading = true;
    notifyListeners();
    http.Response response;
    try {
      response = await http.get(
        'http://dermpro.herokuapp.com//api/v1/topics',
        headers: {HttpHeaders.authorizationHeader: token},
      );
      print(response.statusCode);
      print(response);
      if (response.statusCode == 200) {
        var finalData = json.decode(response.body);
        print(finalData['data']['topics'].length);
        if (finalData['data']['success']) {
          if (finalData['data']['topics'] != null) {
            _topics = new List<Topics>();
            finalData['data']['topics'].forEach((v) {
              _topics.add(new Topics.fromJson(v));
              _articleLoading = false;
            });
            if(_topics.length != null) {
              for (int i = 0; i < _topics.length; i++) {
                BoolObject _valueOfBool = new BoolObject(value : false);
                _listOfBoolObjects.add(_valueOfBool);
              }
            }
            print(_listOfBoolObjects[1].value);
            notifyListeners();
            return {
              'success': true,'message':'success true'
            };
          } else
            _articleLoading = false;
          _topics = null;
          notifyListeners();
            print("some thing went wrong");
            return {
              'success': false,'message':'some thing went wrong'
            };

        }
        print("helo topoics");
        print(_topics);
      } else
        _articleLoading = false;
      _topics = null;
      notifyListeners();
        return {
          'success': false,'message':'some thing went wrong'
        };
        print("server Error");
    } catch (e) {
      _articleLoading = false;
      _topics = null;
      notifyListeners();
      print('helo error');
      return {
        'success': false,'message':'No internet connection'
      };
    }
  }
  changeBoolValue(int index){
    _listOfBoolObjects[index].value = true;
    notifyListeners();
    print(_listOfBoolObjects);
  }
}
