import 'dart:async';
import 'dart:convert';
import 'package:derm_pro/models/skin_question_model.dart';
import 'package:derm_pro/scoped_models/connected_models.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

class RiskModel extends ConnectedModel {
 // bool _skinFlag = false;
  bool _riskFlag = false;
//  List<Questions> _finalQuestions = [];
  List<Questions> _finalRiskQuestions = [];
 // int _currentQuestionIndex = 0;
  int _currentRiskQuestionIndex = 0;
//  Questions _currentQuestion;
  Questions _currentRiskQuestion;
//  Answer _correctAnswer;
//  List<Map<String, dynamic>> _answersList = [];
  int _totalRiskScore = 0;
//  bool _skinTypeSurveyFlag = false;
  bool _riskTypeSurveyFlag = false;
//  FinalSkinResult _finalSkinResult;
   FinalRiskResult _finalRiskResult;

//  bool _skinSelectedFlag = false;
  bool _riskSelectedFlag = false;
//  int _selectedOptionId = null;
  int _riskSelectedOptionId = null;
//  bool _requestSuccessFlag = true;
  bool _riskRequestSuccessFlag = true;
  bool _riskNetWorkErrorFlag = false;
//  bool _netWorkErrorFlag = false;
//  String _descriptions = '';

 /* FinalSkinResult get finalSkinResult{

    return _finalSkinResult;
  }*/
  List<Questions> get allRiskQuestions {
    return List.from(_finalRiskQuestions);
  }
  bool get riskTypeSurveyFlag{
    return _riskTypeSurveyFlag;
  }
  bool get riskFlag {
    return _riskFlag;
  }

  bool get riskRequestSuccessFlag {
    return _riskRequestSuccessFlag;
  }

  bool get riskNetWorkErrorFlag {
    return _riskNetWorkErrorFlag;
  }

  bool get riskSelectedFlag {
    return _riskSelectedFlag;
  }

  int get totalRiskScore{
    return _totalRiskScore;
  }

  int get riskSelectedOptionId {
    return _riskSelectedOptionId;
  }

  Questions get currentRiskQuestion {
    return _currentRiskQuestion;
  }

  int get currentRiskQuestionIndex {
    return _currentRiskQuestionIndex;
  }

  fetchRiskQuestions() async {
    _riskNetWorkErrorFlag = false;
    _riskRequestSuccessFlag = true;
    _currentRiskQuestionIndex = 0;
   // _answersList.clear();
    notifyListeners();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _riskFlag = true;
    notifyListeners();

    final String token = prefs.get('token');
    http.Response response;
    try {
      response = await http.get(
        'http://dermpro.herokuapp.com//api/v1/questions?quiz_id=3',
        headers: {HttpHeaders.authorizationHeader: token},
      );
      var finalData = json.decode(response.body);
      var questionList = finalData['data'];
      if (finalData['data']['success'] == true && finalData['data']['questions'].length > 0) {
        Data _finalResponse = Data.fromJson(questionList);
        _finalRiskQuestions = _finalResponse.questions;
        _riskRequestSuccessFlag = true;
        notifyListeners();
        _riskFlag = false;
        notifyListeners();
        _currentRiskQuestion = _finalRiskQuestions[currentRiskQuestionIndex];
        print(_finalRiskQuestions.length);
        notifyListeners();
      } else {
        //  _requestSuccessFlag = true;
        _riskFlag = false;
        print(_finalRiskQuestions.length);
        print("else part");
        notifyListeners();
      }
      return null;
    } catch (error) {
      _riskRequestSuccessFlag = false;
      Timer(Duration(seconds: 2), () {
        _riskFlag = false;
        _riskNetWorkErrorFlag = true;
        print("in catch block");
        notifyListeners();
      });
      notifyListeners();
    }
  }

  void nextRiskQuestion() {
    _currentRiskQuestionIndex = _currentRiskQuestionIndex + 1;
    _currentRiskQuestion = _finalRiskQuestions[_currentRiskQuestionIndex];
    notifyListeners();
    _riskSelectedOptionId = null;
    _riskSelectedFlag = false;
    notifyListeners();
  }
  void countRiskScore(int score){
    _totalRiskScore = score;
    _riskTypeSurveyFlag = true;
    print(_totalRiskScore);
    notifyListeners();
  }
  void finalRiskResult(String riskDetail, String descriptions,int userId,String skinType) async{
    _finalRiskResult = FinalRiskResult(type:riskDetail,description:descriptions);
    notifyListeners();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String token = prefs.get('token');
    http.Response response;
    try {
      Map<String, dynamic> finalData ={'risk':riskDetail,'user_id':userId,'quiz_id':3};
      print('print result data');
      print(finalData);
      response = await http.post(
        'http://dermpro.herokuapp.com//api/v1/users/attempt_quiz?user_id=${userId}&risk=${riskDetail}&skin_Type=${skinType}&quiz_id=3',
        headers: {HttpHeaders.authorizationHeader: token},
      );
      if (response.statusCode == 200) {
        // If the server did return a 200 OK response, then parse the JSON.
        var finalResponce = json.decode(response.body);
        print("helo shahid kaka");
        print(finalResponce);
      } else {
        print("error");
        // If the server did not return a 200 OK response, then throw an exception.
        throw Exception('Failed to load album');
      }

    }catch(e){
      print("catch bloc skin api");
    }
  }

  void previousRiskQuestion() {
    _currentRiskQuestionIndex = _currentRiskQuestionIndex - 1;
    _currentRiskQuestion = _finalRiskQuestions[_currentRiskQuestionIndex];
    notifyListeners();
    _riskSelectedFlag = false;
    notifyListeners();
  }

  void riskSelectedFlagTrue() {
    _riskSelectedFlag = true;
    print(_riskSelectedOptionId);
    notifyListeners();
  }

  void selectedOptionIdChange(id) {
    _riskSelectedOptionId = id;
  }
 /* Future<Map<String , dynamic>> fetchUserData(int userId) async {
    Map<String, dynamic> firstType = {
      'type': 'Pale white skin',
      'description': 'Extremely sensitive skin, always burns, never tans'
    };
    Map<String, dynamic> secondType = {
      'type': 'White skin',
      'description': 'Very sensitive skin, burns easily, tans minimally'
    };
    Map<String, dynamic> thirdType = {
      'type': 'Light brown skin',
      'description': 'Sensitive skin, sometimes burns, slowly tans to light brown'
    };
    Map<String, dynamic> fourthType = {
      'type': 'Moderate brown skin',
      'description':
      'Mildly sensitive, burns minimally, always tans to moderate brown'
    };
    Map<String, dynamic> fifthType = {
      'type': 'Dark brown skin',
      'description': 'Resistant skin, rarely burns, tans well'
    };
    Map<String, dynamic> sixthType = {
      'type': 'Deeply pigmented dark brown to black skin',
      'description': 'Very resistant skin, never burns, deeply pigmented'
    };

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String token = prefs.get('token');
    try{
      final response = await http.get('http://dermpro.herokuapp.com//api/v1/users/$userId',
        headers: {HttpHeaders.authorizationHeader: token},);

      print(response.statusCode);
      if (response.statusCode == 200) {
        var finalResult = jsonDecode(response.body);
        print('check result in skin model');
        print(finalResult);
        if (finalResult['data']['user'] != null) {
          print(finalResult['data']['user']['user_quizes'].length);
          if (finalResult['data']['user']['user_quizes'].length != 0) {
            int index = finalResult['data']['user']['user_quizes'].length;
            Map<String ,
                dynamic> skinResult = finalResult['data']['user']['user_quizes'][index -
                1];
            print(skinResult);
            if (skinResult['completed'] == true) {
              if (skinResult['skin_type'] == 'Pale White Skin') {
                _skinType = 'Pale White Skin';
                _descriptions = firstType['description'];
                notifyListeners();
              }
              if (skinResult['skin_type'] == 'White Skin') {
                _skinType = 'White Skin';
                _descriptions = secondType['description'];
                notifyListeners();
              }
              if (skinResult['skin_type'] == 'Light Brown Skin') {
                _skinType = 'Light Brown Skin';
                _descriptions = thirdType['description'];
                notifyListeners();
              }
              if (skinResult['skin_type'] == 'Moderate brown Skin') {
                _skinType = 'Moderate Brown Skin';
                _descriptions = fourthType['description'];
                notifyListeners();
              }
              if (skinResult['skin_type'] == 'Dark Brown Skin') {
                _skinType = 'Dark Brown Skin';
                _descriptions = fifthType['description'];
                notifyListeners();
              }
              if (skinResult['skin_type'] ==
                  'Pigmented dark Brown') {
                _skinType = 'Deeply Pigmented Dark';
                _descriptions = sixthType['description'];
                notifyListeners();
              }

              _finalSkinResult =
                  FinalSkinResult(type: skinType , description: descriptions);
              _skinTypeSurveyFlag = true;
              notifyListeners();
              return {'completed': true};
            }
            return {'completed': true};
          }
        }
        else
          print("user not exist");
      } else {
        print("error");
        throw Exception('Failed to load album');
      }
    }catch(e){
      return {'completed':false};
    }
  }*/
}
