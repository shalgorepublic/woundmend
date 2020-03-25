import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:derm_pro/models/query_spot_model.dart';
import 'package:derm_pro/models/read_chat_model.dart';
import 'package:derm_pro/models/tickets_model.dart';
import 'package:derm_pro/models/uv.dart';
import 'package:derm_pro/scoped_models/connected_models.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:dio/dio.dart';

class ChatModel extends ConnectedModel {
  bool _imageLoading = false;
  bool _notificationFlag = false;
  bool _querySpotLoading = false;
  List<ImageData> _images = [];
  List<QuerySpot> _allqueries;
  List<ChatReadFlag> readFlagObjects = [];

  List<QuerySpot> get allQueries {
    return _allqueries;
  }
  bool get  notificationFlag{
    return _notificationFlag;
  }

  void justtosetstate() {
    notifyListeners();
  }
  void setNotificationFlag(){
    _notificationFlag = !_notificationFlag;
    notifyListeners();
    print("helo notiiiiiiiiii flag");
    print(_notificationFlag);
  }

  Future<bool> postImage(File fileImage, String disease, String locationOfmole,String description) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String token = prefs.get('token');
  //  _imageLoading = true;
  //  notifyListeners();
    if (fileImage != null) {
      FormData formData = FormData.fromMap({
        "disease": disease,
        "query_spot_place": locationOfmole,
        "message": description,
        "images": [
          await MultipartFile.fromFile(fileImage.path,
              filename: fileImage.toString())
        ]
      });
      Response response;

      try {
        var dio = Dio();
        response = (await dio.post(
          "http://dermpro.herokuapp.com//api/v1/query_spots",
          data: formData,
          options: new Options(
            headers: {HttpHeaders.authorizationHeader: token},
          ),
        ));
        _imageLoading = false;
        notifyListeners();
        if (response.statusCode == 200) {
          print('request succedes');
          return true;
        } else
          return true;
        print("server Error");
      } catch (e) {
        print(e);
        _imageLoading = false;
        notifyListeners();
        print('helo error');
        return false;
      }
    }
  }
  Future<bool> postImageToGetDisease(File fileImage, String locationOfMole,String message) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String token = prefs.get('token');
    print(token);
    print(fileImage);
    _imageLoading = true;
    notifyListeners();
    if (fileImage != null) {
      print("helo image");
      FormData formData = FormData.fromMap({
        "image":
          await MultipartFile.fromFile(fileImage.path,
              filename: fileImage.toString())
      });
      Response response;

      try {
        var dio = Dio();
        response = (await dio.post(
          "http://178.128.107.65",
          data: formData,
        ));
        _imageLoading = false;
        notifyListeners();
        final Map<String, dynamic> responseData = json.decode(response.toString());
        if (response.statusCode == 200) {
          postImage(fileImage, responseData['prediction'],locationOfMole,message);
          return true;
        } else
          return true;
        print("server Error");
      } catch (e) {
        print(e);
        _imageLoading = false;
        notifyListeners();
        print('helo error');
        return false;
      }
    }
  }

  Future<Map<String, dynamic>> fetchQueriesSpots() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String token = prefs.get('token');
    final int userId = prefs.get('userId');
    print(userId);
    _querySpotLoading = true;
    notifyListeners();
    Response response;
    try {
      final response = await http.get(
        'https://dermpro.herokuapp.com//api/v1/patients/${userId}',
        headers: {HttpHeaders.authorizationHeader: token},
      );
      final Map<String, dynamic> responseData = json.decode(response.body);
      final Map<String, dynamic> finalData = responseData['data'];
      _querySpotLoading = false;
      notifyListeners();
      print(response.statusCode);
      if (response.statusCode == 200) {
        print('request succedes');
//    _allqueries = new List<QuerySpot>();
        _allqueries = List<QuerySpot>.from(
            finalData['user']["query_spots"].map((x) => QuerySpot.fromJson(x)));
        notifyListeners();
        print("heloooooooooooooooooooooooooooooooo");
        print(_allqueries[1].feedbacks[5].userRole);
        return {'success': true};
      } else
        print("server Error");
      return {'success': false};
    } catch (e) {
      print(e);
      _imageLoading = false;
      notifyListeners();
      print('helo error');
      return {};
    }
  }
}
