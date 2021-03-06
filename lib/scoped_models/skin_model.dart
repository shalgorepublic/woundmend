import 'dart:async';
import 'dart:convert';
import 'package:derm_pro/models/skin_question_model.dart';
import 'package:derm_pro/scoped_models/connected_models.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

class SkinModel extends ConnectedModel {
  Data _finalResponse;
  bool _skinFlag = false;
  List<Questions> _finalQuestions = [];
  int _currentQuestionIndex = 0;
  Questions _currentQuestion;
  Answer _correctAnswer;
  List<Map<String, dynamic>> _answersList = [];
  int _totalScore = 0;
  bool _skinTypeSurveyFlag = false;
  FinalSkinResult _finalSkinResult;
  String _firstImage;
  String _secondImage;
  int _color;

  bool _skinSelectedFlag = false;
  int _selectedOptionId = null;
  bool _requestSuccessFlag = true;
  bool _netWorkErrorFlag = false;
  String _skinType = 'Skin Type';
  String _descriptions = '';
  String _riskType = 'Risk Type';
  String _riskDescriptions = '';
  bool _secondRiskTypeFlag = false;

  FinalSkinResult get finalSkinResult {
    return _finalSkinResult;
  }

  List<Questions> get allQuestions {
    return List.from(_finalQuestions);
  }

  String get skinType {
    return _skinType;
  }
  String get firstImage {
    return _firstImage;
  }
  String get secondImage {
    return _secondImage;
  }
  int get color {
    return _color;
  }


  String get descriptions {
    return _descriptions;
  }

  String get riskType {
    return _riskType;
  }

  String get riskDescriptions {
    return _riskDescriptions;
  }

  List<Answer> get allAnswers {
    return List.from(_answersList);
  }

  bool get skinTypeSurveyFlag {
    return _skinTypeSurveyFlag;
  }
  bool get secondRiskTypeFlag{
    return _secondRiskTypeFlag;
  }

  bool get skinFlag {
    return _skinFlag;
  }

  bool get requestSuccessFlag {
    return _requestSuccessFlag;
  }

  bool get netWorkErrorFlag {
    return _netWorkErrorFlag;
  }

  bool get skinSelectedFlag {
    return _skinSelectedFlag;
  }

  int get totalScore {
    return _totalScore;
  }

  int get selectedOptionId {
    return _selectedOptionId;
  }

  Questions get currentQuestion {
    return _currentQuestion;
  }

  int get currentQuestionIndex {
    return _currentQuestionIndex;
  }

  fetchQuestions() async {
    _netWorkErrorFlag = false;
    _requestSuccessFlag = true;
    _currentQuestionIndex = 0;
    _answersList.clear();
    notifyListeners();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _skinFlag = true;
    notifyListeners();

    final String token = prefs.get('token');
    http.Response response;
    try {
      response = await http.get(
        'http://dermpro.herokuapp.com//api/v1/questions?quiz_id=2',
        headers: {HttpHeaders.authorizationHeader: token},
      );
      var finalData = json.decode(response.body);
      var questionList = finalData['data'];
      if (finalData['data']['success'] == true &&
          finalData['data']['questions'].length > 0) {
        Data _finalResponse = Data.fromJson(questionList);
        _finalQuestions = _finalResponse.questions;
        _requestSuccessFlag = true;
        notifyListeners();
        _skinFlag = false;
        notifyListeners();
        _currentQuestion = _finalQuestions[currentQuestionIndex];
        print(_finalQuestions.length);
        notifyListeners();
      } else {
        //  _requestSuccessFlag = true;
        _skinFlag = false;
        print(_finalQuestions.length);
        print("else part");
        notifyListeners();
      }
      return null;
    } catch (error) {
      _requestSuccessFlag = false;
      Timer(Duration(seconds: 2), () {
        _skinFlag = false;
        _netWorkErrorFlag = true;
        print("in catch block");
        notifyListeners();
      });
      notifyListeners();
    }
  }

  void setImagesAndColor(String firstImage, String secondImage, int color){
    _firstImage = firstImage;
    _secondImage = secondImage;
    _color = color;
    notifyListeners();
  }
  void nextQuestion() {
    _currentQuestionIndex = _currentQuestionIndex + 1;
    _currentQuestion = _finalQuestions[currentQuestionIndex];
    notifyListeners();
    _selectedOptionId = null;
    _skinSelectedFlag = false;
    notifyListeners();
  }

  void countScore(int score) {
    _totalScore = score;
    _skinTypeSurveyFlag = true;
    print(_totalScore);
    notifyListeners();
  }

  void finalResult(String skinDetail, String descriptions, int userId,
      String riskDetal) async {
    _finalSkinResult =
        FinalSkinResult(type: skinDetail, description: descriptions);
    notifyListeners();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String token = prefs.get('token');
    http.Response response;
    try {
      Map<String, dynamic> finalData = {
        'skin_type': skinDetail,
        'user_id': userId,
        'quiz_id': 2
      };
      print('print result data');
      print(finalData);
      response = await http.post(
        'http://dermpro.herokuapp.com//api/v1/users/attempt_quiz?user_id=${userId}&skin_type=${skinDetail}&risk=${riskDetal}&quiz_id=2',
        headers: {HttpHeaders.authorizationHeader: token},
      );
      if (response.statusCode == 200) {
        // If the server did return a 200 OK response, then parse the JSON.
        var finalResponce = json.decode(response.body);
        print(finalResponce);
      } else {
        print("error");
        // If the server did not return a 200 OK response, then throw an exception.
        throw Exception('Failed to load album');
      }
    } catch (e) {
      print("catch bloc skin api");
    }
  }

  void previousQuestion() {
    _currentQuestionIndex = _currentQuestionIndex - 1;
    _currentQuestion = _finalQuestions[currentQuestionIndex];
    notifyListeners();
    _skinSelectedFlag = false;
    notifyListeners();
  }

  void submitQuestion(int optionId, int questionId) {
    Map<String, dynamic> myObject = {
      'optionId': optionId,
      'questionId': questionId
    };
    _answersList.add(myObject);
    notifyListeners();
  }

  void skinSelectedFlagTrue() {
    _skinSelectedFlag = true;
    print("heloooooooooooooo");
    print(_skinSelectedFlag);
    notifyListeners();
  }

  void selectedOptionIdChange(id) {
    _selectedOptionId = id;
    print(_selectedOptionId);
    notifyListeners();
  }

  Future<Map<String, dynamic>> fetchUserData(int userId) async {
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
      'description':
          'Sensitive skin, sometimes burns, slowly tans to light brown'
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
    try {
      final response = await http.get(
        'http://dermpro.herokuapp.com//api/v1/users/$userId',
        headers: {HttpHeaders.authorizationHeader: token},
      );

      print(response.statusCode);
      if (response.statusCode == 200) {

        var finalResult = jsonDecode(response.body);
        print(finalResult);
        print('check result in skin model');
        print(finalResult);
        if (finalResult['data']['user'] != null) {
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('avatar',"http://dermpro.herokuapp.com${finalResult['data']['user']['avatar']}");
          notifyListeners();
          print(finalResult['data']['user']['user_quizes'].length);
          if (finalResult['data']['user']['user_quizes'].length != 0) {
            int index = finalResult['data']['user']['user_quizes'].length;
            Map<String, dynamic> skinResult =
                finalResult['data']['user']['user_quizes'][index - 1];
            print(skinResult);
            if (skinResult['completed'] == true) {
              if (skinResult['skin_type'] == 'Pale White Skin') {
                _skinType = 'Pale White Skin';
                _descriptions = firstType['description'];
                _firstImage = 'assets/ninthimage.png';
                _secondImage = 'assets/firstimage.png';
                _color = 0xFFEFDC62;
                _totalScore = 1;
                notifyListeners();
              }
              if (skinResult['skin_type'] == 'White Skin') {
                _skinType = 'White Skin';
                _descriptions = secondType['description'];
                _firstImage ='assets/eleventhimage.png';
                _secondImage = 'assets/twelthimage.png';
                _color = 0xFFE9B964;
                _totalScore = 7;
                notifyListeners();
              }
              if (skinResult['skin_type'] == 'Light Brown Skin') {
                _skinType = 'Light Brown Skin';
                _descriptions = thirdType['description'];
                _firstImage = 'assets/tenthimage.png';
                _secondImage = 'assets/secondimage.png';
                _color = 0xFFB06639;
                _totalScore = 14;
                notifyListeners();
              }
              if (skinResult['skin_type'] == 'Moderate brown Skin') {
                _skinType = 'Moderate Brown Skin';
                _descriptions = fourthType['description'];
                _firstImage = 'assets/thirdimage.png';
                _secondImage = 'assets/fourthimage.png';
                _color = 0xFF8E5029;
                _totalScore = 21;
                notifyListeners();
              }
              if (skinResult['skin_type'] == 'Dark Brown Skin') {
                _skinType = 'Dark Brown Skin';
                _descriptions = fifthType['description'];
                _firstImage = 'assets/fifthimage.png';
                _secondImage = 'assets/sixthimage.png';
                _color = 0xFF793308;
                _totalScore = 28;
                notifyListeners();
              }
              if (skinResult['skin_type'] == 'Pigmented dark Brown') {
                _skinType = 'Deeply Dark';
                _descriptions = sixthType['description'];
                _firstImage = 'assets/seventhimage.png';
                _secondImage = 'assets/eightimage.png';
                _color = 0xFF351A1D;
                _totalScore= 35;
                notifyListeners();
              }
              if (skinResult['risk'] == 'Low Risk') {
                _riskType = 'Low Risk';
                _riskDescriptions =
                    'You have not answered any questions with yes.This means you do not have the characteristics of someone with a risk profile to develope melanoma, however you can never be sure you will not develope melanoma.';
                _secondRiskTypeFlag = true;
                notifyListeners();
              }
              if (skinResult['risk'] == 'High Risk') {
                _riskType = 'High Risk';
                _riskDescriptions =
                    'The questions are aimed to find out whether you have a risk profile to develope melanoma.You have answered one or multiple questions with yes.This means you are one of many who are at risk of developing a melanoma.';
                _secondRiskTypeFlag = true;
                notifyListeners();
              }

              _finalSkinResult =
                  FinalSkinResult(type: skinType, description: descriptions);
              _skinTypeSurveyFlag = true;
              notifyListeners();
              return {'completed': true};
            }
            return {'completed': true};
          }
        } else
          print("user not exist");
        return {'completed':true};
      } else {
        print("error");
        throw Exception('Failed to load album');
      }
    } catch (e) {
      return {'completed': false};
    }
  }
  updateToken(String fcmToken)async{
    http.Response response;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String token = prefs.get('token');
    final int userId = prefs.get('userId');

    final Map<String , dynamic> updatedData = {'fcm_token': fcmToken};
    try {
      response = await http.put(
          'http://dermpro.herokuapp.com//api/v1/users/${userId}',
          body: updatedData,headers:{'Authorization':'Bearer $token'}
      );
      final Map<String , dynamic> responseData = json.decode(response.body);
      print("helooooooooooo responce");
      print(responseData['data']['message']);
    }catch(e){

    }
  }
}
