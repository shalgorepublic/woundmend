import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:derm_pro/models/auth.dart';
import 'package:derm_pro/models/user_model.dart';
import 'package:dio/dio.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rxdart/subjects.dart';

class ConnectedModel extends Model {
  User _authenticatedUser;
  bool _isLoading = false;
  bool _alertFlag = false;
}

class UserModel extends ConnectedModel {
  AuthMode _mode = AuthMode.SignUp;
  bool _imageUploadingFlag = false;

  AuthMode get mode => _mode;
  File _userImage;

  final PublishSubject<bool> _userSubject = PublishSubject();

  User get user {
    return _authenticatedUser;
  }

  bool get loading {
    return _isLoading;
  }

  bool get imageUploadingFlag {
    return _imageUploadingFlag;
  }

  bool get alertFlag {
    return _alertFlag;
  }

  PublishSubject<bool> get userSubject {
    return _userSubject;
  }

  void changeMode(AuthMode mode) {
    _mode = mode;
    notifyListeners();
    print(_mode);
  }
  void removeImage()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('avatar');
    final int avatar = prefs.get('avatar');
    print("avataaaaaaaaaaar");
    print(avatar);
    _authenticatedUser = User(
        id: _authenticatedUser.id,
        email: _authenticatedUser.email,
        firstName: _authenticatedUser.firstName,
        lastName: _authenticatedUser.lastName,
        dob: _authenticatedUser.dob,
        phoneNumber: _authenticatedUser.phoneNumber,
        otp: _authenticatedUser.otp,
        token: _authenticatedUser.token,
        password: _authenticatedUser.password,
        image: null);
    notifyListeners();
  }

  Future<bool> saveImage(File fileImage) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String token = prefs.get('token');
    final int userId = prefs.get('userId');
    notifyListeners();
    if (fileImage != null) {
      FormData formData = FormData.fromMap({
        "avatar": await MultipartFile.fromFile(fileImage.path,
            filename: fileImage.toString())
      });
      _imageUploadingFlag = true;
      notifyListeners();
      Response response;
      print(formData);
      try {
        var dio = Dio();
        response = await dio.put(
          "http://dermpro.herokuapp.com//api/v1/users/${userId}",
          data: formData,
          options: new Options(
            headers: {HttpHeaders.authorizationHeader: token},
          ),
        );
        if (response.statusCode == 200) {
          print('request succedes');
          print(response.data['data']['user']['avatar']);
          //   final Map<String , dynamic> finalData = response.data;
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('avatar',
              "http://dermpro.herokuapp.com${response.data['data']['user']['avatar']}");
          notifyListeners();
          final String avatarImage = prefs.get('avatar');
          _authenticatedUser = User(
              id: _authenticatedUser.id,
              email: _authenticatedUser.email,
              firstName: _authenticatedUser.firstName,
              lastName: _authenticatedUser.lastName,
              dob: _authenticatedUser.dob,
              phoneNumber: _authenticatedUser.phoneNumber,
              otp: _authenticatedUser.otp,
              token: _authenticatedUser.token,
              password: _authenticatedUser.password,
              image: avatarImage);
          notifyListeners();
          print(_authenticatedUser.image);
          return true;
        } else
          print("helo internal error");
        _imageUploadingFlag = false;
        notifyListeners();
        print("server Error");
        return false;
      } catch (e) {
        _imageUploadingFlag = false;
        print(e);
        print('helo error');
        return false;
      }
    }
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
        final Map<String, dynamic> signUpAuthData = {
          'email': email,
          'password': password,
          'first_name': firstName,
          'last_name': lastName,
          'contact_no': phoneNumber,
          'dob': date
        };
        response = await http.post(
          'http://dermpro.herokuapp.com//api/v1/users/signup?',
          body: signUpAuthData,
        );
        final Map<String, dynamic> responseData = json.decode(response.body);
        final Map<String, dynamic> finalData = responseData['data'];
        print("helo responce");
        print(finalData);
        bool hasError = true;
        String message = 'Something went wrong.';
        if (finalData['success'] == true) {
          final SharedPreferences prefs =
          await SharedPreferences.getInstance();
          prefs.setInt('userId', finalData['user']['id']);
        //  prefs.setString('token', finalData['auth_token']);
          hasError = false;
          message = 'Authentication Succeeded';
          _authenticatedUser = User(
            id: finalData['user']['id'],
            email: email,
            firstName: finalData['user']['first_name'],
            lastName: finalData['user']['last_name'],
            dob: finalData['user']['dob'],
            phoneNumber: finalData['user']['contact_no'],
            otp: finalData['user']['confirmation_code'],
            token: finalData['auth_token'],
            image: finalData['avatar'],
            password: password,
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
        return {'success': true, 'data': json.decode(response.body)};
      } else {
        final Map<String, dynamic> loginAuthData = {
          'email': email,
          'password': password,
        };
        response = await http.post(
          'http://dermpro.herokuapp.com//api/v1/users/login?',
          body: loginAuthData,
        );
        final Map<String, dynamic> responseData = json.decode(response.body);
        final Map<String, dynamic> finalData = responseData['data'];
        bool hasError = true;
        _isLoading = true;
        notifyListeners();
        print(finalData);
        String message = 'Something went wrong.';
        if (finalData['success'] == true) {
          hasError = false;
          message = 'Authentication Succeeded';
         if(finalData['user']['number_verified']) {
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
               image: finalData['user']['avatar']);
           notifyListeners();
           _isLoading = false;
           notifyListeners();
           final SharedPreferences prefs = await SharedPreferences
               .getInstance();
           prefs.setString('token' , _authenticatedUser.token);
           prefs.setString('userEmail' , email);
           prefs.setString('password' , password);
           prefs.setInt('userId' , finalData['user']['id']);
           prefs.setString('first_name' , _authenticatedUser.firstName);
           print(_authenticatedUser.firstName);
           prefs.setString('last_name' , _authenticatedUser.lastName);
           prefs.setString('dob' , _authenticatedUser.dob);
           prefs.setString('contact_no' , _authenticatedUser.phoneNumber);
           prefs.setString('avatar' ,
               "http://dermpro.herokuapp.com${_authenticatedUser.image}");
         }
         else{
           _isLoading = false;
           notifyListeners();
           return{'success':true,'data':json.decode(response.body)};
         }
        } else if (finalData['message'] ==
            'Account already exists for this email') {
          message = 'This Email is already exists.';
          _isLoading = false;
          notifyListeners();
        }
        _isLoading = false;
        notifyListeners();
        return {'success': true, 'data': json.decode(response.body)};
      }
    } catch (error) {
      _isLoading = false;
      notifyListeners();
      return {
        'success': false,
        'data': {null}
      };
    }
  }

  void autoAuthenticate() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String token = prefs.get('token');
    final String userEmail = prefs.get('userEmail');
    final String first_name = prefs.get('first_name');
    final String last_name = prefs.get('last_name');
    final String dob = prefs.get('dob');
    final String contact_no = prefs.get('contact_no');
    final String password = prefs.get('password');
    final int userId = prefs.get('userId');
    final String image = prefs.get('avatar');
    print(image);
    print(userEmail);
    print(first_name);
    print(last_name);
    print(token);
    print(dob);
    print(userId);
    if (token != null) {
      _authenticatedUser = User(
          id: userId,
          email: userEmail,
          firstName: first_name,
          lastName: last_name,
          dob: dob,
          phoneNumber: contact_no,
          otp: null,
          token: token,
          password: password,
          image: image);
      _alertFlag = true;
      _userSubject.add(true);
      notifyListeners();
    } else {
      _userSubject.add(false);
      notifyListeners();
    }
  }

  void logout() async {
    _userSubject.add(false);
    _authenticatedUser = null;
   // notifyListeners();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    prefs.remove('userEmail');
    prefs.remove('userId');
    prefs.remove('first_name');
    prefs.remove('last_name');
    prefs.remove('dob');
    prefs.remove('contact_no');
    prefs.remove('password');
    prefs.remove('avatar');
    notifyListeners();
  }

  Future<Map<String, dynamic>> forgotPassword(name) async {
    http.Response response;
    _isLoading = true;
    notifyListeners();
    final Map<String, dynamic> userEmail = {'email': name};
    try {
      response = await http.post(
          'http://dermpro.herokuapp.com//api/v1/users/forget_password?',
          body: userEmail);
      final Map<String, dynamic> responseData = json.decode(response.body);

      final Map<String, dynamic> finalData = responseData['data'];
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
        return {'success': true, 'message': finalData['message']};
      } else
        _isLoading = false;
      notifyListeners();
      return {'success': true, 'message': finalData['message']};
    } catch (error) {
      _isLoading = false;
      notifyListeners();
      return {'success': false, 'message': "Some thing went wrong"};
    }
  }

  Future<Map<String, dynamic>> update(String name, String lastName, String dob,
      int userId, String gender) async {
    http.Response response;
    _isLoading = true;
    notifyListeners();
    final Map<String, dynamic> updatedData = {
      'first_name': name,
      'last_name': lastName,
      'dob': dob,
      'gender': gender
    };
    String token = _authenticatedUser.token;
    try {
      response = await http.put(
          'http://dermpro.herokuapp.com//api/v1/users/${userId}',
          body: updatedData,
          headers: {'Authorization': 'Bearer $token'});
      final Map<String, dynamic> responseData = json.decode(response.body);
      final Map<String, dynamic> finalData = responseData['data'];
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
            id: finalData['user']['id'],
            email: finalData['user']['email'],
            firstName: finalData['user']['first_name'],
            lastName: finalData['user']['last_name'],
            dob: finalData['user']['dob'],
            phoneNumber: finalData['user']['contact_no'],
            otp: finalData['user']['confirmation_code'],
            image: finalData['user']['avatar'],
            token: finalData['auth_token'],
            password: _authenticatedUser.password);
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('token', finalData['auth_token']);
        prefs.setString('userEmail', finalData['user']['email']);
        prefs.setString('password', _authenticatedUser.password);
        prefs.setInt('userId', finalData['user']['id']);
        prefs.setString('first_name', finalData['user']['first_name']);
        prefs.setString('last_name', finalData['user']['last_name']);
        prefs.setString('dob', finalData['user']['dob']);
        prefs.setString('contact_no', finalData['user']['contact_no']);
        prefs.setString('avatar', finalData['user']['avatar']);
        notifyListeners();
        return {'success': true, 'message': finalData['message']};
      } else
        _isLoading = false;
      notifyListeners();
      return {'success': true, 'message': finalData['message']};
    } catch (error) {
      _isLoading = false;
      notifyListeners();
      return {'success': false, 'message': "Some thing went wrong"};
    }
  }
  Future<Map<String, dynamic>>  sendOtpCode(String otp, ) async {
    http.Response response;
    _isLoading = true;
    notifyListeners();
    final Map<String, dynamic> updatedData = {
      'confirmation_code': otp,
    };
    String token = _authenticatedUser.token;
    int userId = _authenticatedUser.id;
    try {
      response = await http.put(
          'http://dermpro.herokuapp.com//api/v1/users/verify_number',
          body: updatedData,
          headers: {'Authorization': 'Bearer $token'});
      final Map<String, dynamic> responseData = json.decode(response.body);
      final Map<String, dynamic> finalData = responseData['data'];
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
            id: finalData['user']['id'],
            email: finalData['user']['email'],
            firstName: finalData['user']['first_name'],
            lastName: finalData['user']['last_name'],
            dob: finalData['user']['dob'],
            phoneNumber: finalData['user']['contact_no'],
            otp: finalData['user']['confirmation_code'],
            image: finalData['user']['avatar'],
            token: finalData['auth_token'],
            password: _authenticatedUser.password);
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('token', finalData['auth_token']);
        prefs.setString('userEmail', finalData['user']['email']);
        prefs.setString('password', _authenticatedUser.password);
        prefs.setInt('userId', finalData['user']['id']);
        prefs.setString('first_name', finalData['user']['first_name']);
        prefs.setString('last_name', finalData['user']['last_name']);
        prefs.setString('dob', finalData['user']['dob']);
        prefs.setString('contact_no', finalData['user']['contact_no']);
        prefs.setString('avatar', finalData['user']['avatar']);
        notifyListeners();
        return {'success': true, 'message': finalData['message']};
      } else
        _isLoading = false;
      notifyListeners();
      return {'success': true, 'message': finalData['message']};
    } catch (error) {
      _isLoading = false;
      notifyListeners();
      return {'success': false, 'message': "Some thing went wrong"};
    }
  }
  Future<Map<String, dynamic>>  reSendOtpCode() async {
    final SharedPreferences prefs =
    await SharedPreferences.getInstance();
    final int userId = prefs.get('userId');
    http.Response response;
    final Map<String, dynamic> updatedData = {
      'user_id': userId
    };
 //   _isLoading = true;
 //   notifyListeners();
    try {
      response = await http.put(
          'http://dermpro.herokuapp.com//api/v1/users/resend_otp',
          body: {'user_id':userId.toString()});
      final Map<String, dynamic> responseData = json.decode(response.body);
      final Map<String, dynamic> finalData = responseData['data'];
      bool hasError = true;
      _isLoading = true;
      notifyListeners();
      String message = 'Something went wrong.';
      if (finalData['message'] == "Updated") {
        hasError = false;
        message = 'Authentication Succeeded';
        _isLoading = false;
        _authenticatedUser = User(
            id: finalData['user']['id'],
            email: finalData['user']['email'],
            firstName: finalData['user']['first_name'],
            lastName: finalData['user']['last_name'],
            dob: finalData['user']['dob'],
            phoneNumber: finalData['user']['contact_no'],
            otp: finalData['user']['confirmation_code'],
            image: finalData['user']['avatar'],
            token: finalData['auth_token'],
            password: _authenticatedUser.password);

        notifyListeners();
        return {'success': true, 'message': finalData};
      } else
        _isLoading = false;
      notifyListeners();
      return {'success': true, 'message': finalData['message']};
    } catch (error) {
      _isLoading = false;
      notifyListeners();
      return {'success': false, 'message': "Some thing went wrong"};
    }
  }

  alertFlagTrue() {
    _alertFlag = true;
    notifyListeners();
    //   return true;
  }

  alertFlagFalse() {
    _alertFlag = false;
    notifyListeners();
    //   return true;
  }
}

class UtilityModel extends ConnectedModel {
  bool get isLoading {
    return _isLoading;
  }
}
