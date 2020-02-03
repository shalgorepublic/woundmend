import 'dart:convert';
import 'dart:async';
import 'package:derm_pro/models/auth.dart';
import 'package:derm_pro/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rxdart/subjects.dart';

class ConnectedModel extends Model {
  User _authenticatedUser;
  bool _isLoading = false;
}

class UserModel extends ConnectedModel {
  AuthMode _mode = AuthMode.SignUp;

  AuthMode get mode => _mode;

  final PublishSubject <bool> _userSubject = PublishSubject();

  User get user {
    return _authenticatedUser;
  }
  PublishSubject<bool> get userSubject {
    return _userSubject;
  }

  void changeMode(AuthMode mode) {
    _mode = mode;
    notifyListeners();
    print(_mode);
  }

  Future<Map<String, dynamic>> authenticate(String email, String password,
      [String firstName,
      String lastName,
      String date,
      String phoneNumber]) async {
    _isLoading = true;
    notifyListeners();
    http.Response response;
    try {
      if (mode == AuthMode.SignUp) {
        final Map<String , dynamic> signUpAuthData = {
          'email': email ,
          'password': password ,
          'first_name': firstName ,
          'last_name': lastName ,
          'contact_no': phoneNumber ,
          'dob': date
        };
        response = await http.post(
          'http://dermpro.herokuapp.com//api/v1/users/signup?' ,
          body: signUpAuthData ,
        );
        final Map<String , dynamic> responseData = json.decode(response.body);
        final Map<String , dynamic> finalData = responseData['data'];
        bool hasError = true;
        String message = 'Something went wrong.';
        if (finalData['success'] == true) {
          hasError = false;
          message = 'Authentication Succeeded';
          _authenticatedUser = User(
            id: finalData['user']['id'] ,
            email: email ,
            firstName: finalData['user']['first_name'] ,
            lastName: finalData['user']['last_name'] ,
            dob: finalData['user']['dob'] ,
            phoneNumber: finalData['user']['contact_no'] ,
            otp: finalData['user']['confirmation_code'] ,
            token: finalData['auth_token'],
            password: password ,
          );
          _userSubject.add(true);
          _isLoading = false;
          notifyListeners();
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('token' , finalData['auth_token']);
          prefs.setString('userEmail' , email);
          prefs.setInt('userId' , finalData['user']['id']);
        } else if (finalData['message'] ==
            'Account already exists for this email') {
          message = 'This Email is already exists.';
          _isLoading = false;
          notifyListeners();
        }
        _isLoading = false;
        notifyListeners();
        return {'success': true, 'data': json.decode(response.body)};
      } else {
        final Map<String , dynamic> loginAuthData = {
          'email': email ,
          'password': password ,
        };
        response = await http.post(
          'http://dermpro.herokuapp.com//api/v1/users/login?' ,
          body: loginAuthData ,
        );
        final Map<String , dynamic> responseData = json.decode(response.body);
        final Map<String , dynamic> finalData = responseData['data'];
        bool hasError = true;
        String message = 'Something went wrong.';
        if (finalData['success'] == true) {
          hasError = false;
          message = 'Authentication Succeeded';
          _authenticatedUser = User(
            id: finalData['user']['id'] ,
            email: email ,
            firstName: finalData['user']['first_name'] ,
            lastName: finalData['user']['last_name'] ,
            dob: finalData['user']['dob'] ,
            phoneNumber: finalData['user']['contact_no'] ,
            otp: finalData['user']['confirmation_code'] ,
            token: finalData['auth_token'] ,
            password: password ,
          );
          print(_authenticatedUser.otp);
          print(_authenticatedUser.token);
          _isLoading = false;
          notifyListeners();
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('token' , finalData['auth_token']);
          prefs.setString('userEmail' , email);
          prefs.setInt('userId' , finalData['user']['id']);
        } else if (finalData['message'] ==
            'Account already exists for this email') {
          message = 'This Email is already exists.';
          _isLoading = false;
          notifyListeners();
        }
        _isLoading = false;
        notifyListeners();
        return {'success': true,'data': json.decode(response.body)};
      }
    }catch(error){
      _isLoading = false;
      return{'success':false,'data':{null} };
  }}

   void autoAuthenticate() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String token = prefs.get('token');
    if (token != null) {
      _userSubject.add(true);
      notifyListeners();
    }
    final String userEmail = prefs.get('userEmail');
    _userSubject.add(true);
    notifyListeners();
  }
  void logout() async {
    _userSubject.add(false);
    _authenticatedUser = null;
    notifyListeners();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    prefs.remove('userEmail');
    prefs.remove('userId');
  }
}

class UtilityModel extends ConnectedModel {
  bool get isLoading {
    return _isLoading;
  }
}
