import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:derm_pro/models/articles_model.dart';
import 'package:derm_pro/models/tickets_model.dart';
import 'package:derm_pro/scoped_models/connected_models.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:dio/dio.dart';

class SettingsModel extends ConnectedModel {
  bool _supportMessageLoading = false;
  bool _fetchTicketsLoading = false;
  List<Ticket> _tickets = [];

  List<Ticket> get allTickets {
    return  List.from(_tickets);
  }

  bool get supportMessageLoading {
    return _supportMessageLoading;
  }

  bool get fetchTicketsLoading {
    return _fetchTicketsLoading;
  }

  Future<Map<String, dynamic>> postInquiry(
      String message, File fileImage) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String token = prefs.get('token');
    _supportMessageLoading = true;
    print(_supportMessageLoading);
    notifyListeners();
    if (fileImage != null) {
      print("helo image");
      FormData formData = FormData.fromMap({
        "title": message,
        "images": await MultipartFile.fromFile(fileImage.path,
            filename: fileImage.toString()),
      });
      Response response;

      try {
        var dio = Dio();
        response = (await dio.post(
          "http://dermpro.herokuapp.com//api/v1/tickets",
          data: formData,
          options: new Options(
            headers: {HttpHeaders.authorizationHeader: token},
          ),
        ));
        print(response.statusCode);
        print("message respoce");
        print(response);
        _supportMessageLoading = false;
        notifyListeners();
        print(_supportMessageLoading);
        if (response.statusCode == 200) {
          print('request succedes');
          return {'success': true, 'message': 'request succedes'};
        } else
          return {'success': false, 'message': 'some thing went wrong'};
        print("server Error");
      } catch (e) {
        print(e);
        _supportMessageLoading = false;
        notifyListeners();
        print('helo error');
        return {'success': false, 'message': 'No internet connection'};
      }
    } else {
      print("helo null image");
      FormData formData = FormData.fromMap({
        "title": message,
      });
      Response response;

      try {
        var dio = Dio();
        response = (await dio.post(
          "http://dermpro.herokuapp.com//api/v1/tickets",
          data: formData,
          options: new Options(
            headers: {HttpHeaders.authorizationHeader: token},
          ),
        ));

        print(response.statusCode);
        print("message respoce");
        print(response);
        _supportMessageLoading = false;
        notifyListeners();
        print(_supportMessageLoading);
        if (response.statusCode == 200) {
          print('request succedes');
          return {'success': true, 'message': 'request succedes'};
        } else
          return {'success': false, 'message': 'some thing went wrong'};
        print("server Error");
      } catch (e) {
        print(e);
        _supportMessageLoading = false;
        notifyListeners();
        print('helo error');
        return {'success': false, 'message': 'No internet connection'};
      }
    }
  }

  Future<Map<String, dynamic>> fetchAllTickets() async {
    _fetchTicketsLoading = true;
    notifyListeners();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String token = prefs.get('token');
    http.Response response;
    try {
      response = await http.get(
        'http://dermpro.herokuapp.com//api/v1/tickets',
        headers: {HttpHeaders.authorizationHeader: token},

      );
      print("data2");
      print(response.body);
      var temp_data = jsonDecode(response.body);

      final ticketclass = ticketclassFromJson(response.body);
      _tickets = ticketclass.data.tickets;
      print(_tickets.length);
      _fetchTicketsLoading = false;
      notifyListeners();
    } catch (error) {
      print(error);
      _fetchTicketsLoading = false;

      _fetchTicketsLoading = false;
      print("in catch block");
      notifyListeners();
      notifyListeners();
    }
  }
}
