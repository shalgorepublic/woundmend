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
  bool _querySpotLoading = false;
  List<ImageData> _images = [];
  List<QuerySpot> _allqueries;
  List<ChatReadFlag> readFlagObjects = [];

  List<QuerySpot> get allQueries {
    return _allqueries;
  }

  /* List<ChatReadFlag> get readFlagObjects {
    return _readFlagObjects;
  }*/

  void justtosetstate() {
    notifyListeners();
  }

  Future<bool> postImage(File fileImage, String message) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String token = prefs.get('token');
    print(token);
    print(fileImage);
    print("helo image");
    print(message);
    _imageLoading = true;
    notifyListeners();
    if (fileImage != null) {
      print("helo image");
      FormData formData = FormData.fromMap({
        "message": "disease",
        "query_spot_place": message,
        "images": [
          await MultipartFile.fromFile(fileImage.path,
              filename: fileImage.toString())
        ]
      });
      print(fileImage.path);
      print("formData");
      print(formData);
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
        'http://dermpro.herokuapp.com//api/v1/patients/${userId}',
        headers: {HttpHeaders.authorizationHeader: token},
      );
      print(response.statusCode);
      print("query spot responce");
      print(response);
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
