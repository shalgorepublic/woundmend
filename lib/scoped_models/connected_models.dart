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
  bool get loading {
    return _isLoading;
  }

  PublishSubject<bool> get userSubject {
    return _userSubject;
  }

  void changeMode(AuthMode mode) {
    _mode = mode;
    notifyListeners();
    print(_mode);
  }

  Future<Map<String , dynamic>> authenticate(String email , String password ,
      [String firstName ,
        String lastName ,
        String date ,
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
            token: finalData['auth_token'] ,
            password: password ,
          );
          _userSubject.add(true);
          _isLoading = false;
          notifyListeners();
        } else if (finalData['message'] ==
            'Account already exists for this email') {
          message = 'This Email is already exists.';
          _isLoading = false;
          notifyListeners();
        }
        _isLoading = false;
        notifyListeners();
        return {'success': true , 'data': json.decode(response.body)};
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
        _isLoading = true;
        notifyListeners();
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
          print(_authenticatedUser.id);
          _isLoading = false;
          notifyListeners();
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('token' , finalData['auth_token']);
          prefs.setString('userEmail' , email);
          prefs.setString('password' , password);
          prefs.setInt('userId' , finalData['user']['id']);
          prefs.setString('first_name' , finalData['user']['first_name']);
          prefs.setString('last_name' , finalData['user']['last_name']);
          prefs.setString('dob' , finalData['user']['dob']);
          prefs.setString('contact_no' , finalData['user']['contact_no']);
        } else if (finalData['message'] ==
            'Account already exists for this email') {
          message = 'This Email is already exists.';
          _isLoading = false;
          notifyListeners();
        }
        _isLoading = false;
        notifyListeners();
        return {'success': true , 'data': json.decode(response.body)};
      }
    } catch (error) {
      _isLoading = false;
      notifyListeners();
      return {'success': false , 'data': {null}};
    }
  }

  void autoAuthenticate() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String token = prefs.get('token');
    final int UserId = prefs.get('userId');
    final String userEmail = prefs.get('userEmail');
    final String first_name = prefs.get('first_name');
    final String last_name = prefs.get('last_name');
    final String dob = prefs.get('dob');
    final String contact_no = prefs.get('contact_no');
    final String password = prefs.get('password');
    print(userEmail);
    print(first_name);
    print(last_name);
    print(token);
    print(dob);
    if (token != null) {
      _userSubject.add(true);
      _authenticatedUser = User(
        id: UserId ,
        email: userEmail ,
        firstName: first_name ,
        lastName: last_name ,
        dob: dob ,
        phoneNumber: contact_no ,
        otp: null,
        token: token,
        password: password,
      );
      notifyListeners();
    }
    else {
      _userSubject.add(false);
      notifyListeners();
    }
  }

  void logout() async {
    _userSubject.add(false);
    _authenticatedUser = null;
    notifyListeners();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    prefs.remove('userEmail');
    prefs.remove('userId');
    prefs.remove('first_name');
    prefs.remove('last_name');
    prefs.remove('dob');
    prefs.remove('contact_no');
    prefs.remove('password');
  }
  Future<Map<String , dynamic>> forgotPassword(name) async {
    http.Response response;
    _isLoading = true;
    notifyListeners();
    final Map<String , dynamic> userEmail = {'email': name};
    try {
      response = await http.post(
          'http://dermpro.herokuapp.com//api/v1/users/forget_password?' ,
          body: userEmail
      );
      final Map<String , dynamic> responseData = json.decode(response.body);

      final Map<String , dynamic> finalData = responseData['data'];
      bool hasError = true;
      _isLoading = true;
      notifyListeners();
      print(finalData);
      String message = 'Something went wrong.';
      if (finalData['success'] == true) {
        hasError = false;
        message = 'Authentication Succeeded';
        _isLoading = false;
        notifyListeners();
        return{'success':true, 'message':finalData['message']};
      } else
        _isLoading = false;
      notifyListeners();
      return {'success': true , 'message': finalData['message']};
    } catch (error) {
      _isLoading = false;
      notifyListeners();
      return {'success': false , 'message': "Some thing went wrong"};
    }
  }
  Future<Map<String , dynamic>> update(String name,String lastName,String dob,int userId,String gender) async {
    http.Response response;
    _isLoading = true;
    notifyListeners();
    final Map<String , dynamic> updatedData = {'first_name': name,'last_name':lastName,'dob':dob,'gender': gender};
    String token = _authenticatedUser.token;
    try {
      response = await http.put(
          'http://dermpro.herokuapp.com//api/v1/users/${userId}',
          body: updatedData,headers:{'Authorization':'Bearer $token'}
      );
      final Map<String , dynamic> responseData = json.decode(response.body);
      final Map<String , dynamic> finalData = responseData['data'];
      bool hasError = true;
      _isLoading = true;
      print("helo shahdi");
      print(finalData);
      notifyListeners();
      String message = 'Something went wrong.';
      if (finalData['message'] == "Updated") {
        print("helo checking");
        hasError = false;
        message = 'Authentication Succeeded';
        _isLoading = false;
        _authenticatedUser = User(
          id: finalData['user']['id'] ,
          email: finalData['user']['email'] ,
          firstName: finalData['user']['first_name'] ,
          lastName: finalData['user']['last_name'] ,
          dob: finalData['user']['dob'],
          phoneNumber: finalData['user']['contact_no'] ,
          otp: finalData['user']['confirmation_code'] ,
          token: finalData['auth_token'],
          password: _authenticatedUser.password
        );
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('token' , finalData['auth_token']);
        prefs.setString('userEmail' , finalData['user']['email']);
        prefs.setString('password' , _authenticatedUser.password);
        prefs.setInt('userId' , finalData['user']['id']);
        prefs.setString('first_name' , finalData['user']['first_name']);
        prefs.setString('last_name' , finalData['user']['last_name']);
        prefs.setString('dob' , finalData['user']['dob']);
        prefs.setString('contact_no' , finalData['user']['contact_no']);
        notifyListeners();
        return{'success':true, 'message':finalData['message']};
      } else
        _isLoading = false;
      notifyListeners();
      return {'success': true , 'message': finalData['message']};
    } catch (error) {
      _isLoading = false;
      notifyListeners();
      return {'success': false , 'message': "Some thing went wrong"};
    }
}
}

class UtilityModel extends ConnectedModel {
  bool get isLoading {
    return _isLoading;
  }
}
