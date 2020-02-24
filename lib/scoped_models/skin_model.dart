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

  bool _skinSelectedFlag = false;
  int _selectedOptionId = null;
  bool _requestSuccessFlag = true;
  bool _netWorkErrorFlag = false;
  String _skinType = 'skin Type';
  String _descriptions = '';

  FinalSkinResult get finalSkinResult{

    return _finalSkinResult;
}
  List<Questions> get allQuestions {
    return List.from(_finalQuestions);
  }
  String get skinType{
    return _skinType;
  }
  String get descriptions{
    return _descriptions;
  }
  List<Answer> get allAnswers {
    return List.from(_answersList);
  }
  bool get skinTypeSurveyFlag{
    return _skinTypeSurveyFlag;
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

  int get totalScore{
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
    print(_netWorkErrorFlag);
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
      if (finalData['data']['success'] == true && finalData['data']['questions'].length > 0) {

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

  void nextQuestion() {
    _currentQuestionIndex = _currentQuestionIndex + 1;
    _currentQuestion = _finalQuestions[currentQuestionIndex];
    notifyListeners();
    _selectedOptionId = null;
    _skinSelectedFlag = false;
    notifyListeners();
  }
  void countScore(int score){
    _totalScore = score;
    _skinTypeSurveyFlag = true;
    print(_totalScore);
    notifyListeners();
  }
  void finalResult(String skinDetail, String descriptions,int userId) async{
    _finalSkinResult = FinalSkinResult(type:skinDetail,description:descriptions);
    notifyListeners();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String token = prefs.get('token');
    http.Response response;
    try {
      Map<String, dynamic> finalData ={'skin_type':skinDetail,'user_id':userId,'quiz_id':2};
      print('print result data');
      print(finalData);
      response = await http.post(
        'http://dermpro.herokuapp.com//api/v1/users/attempt_quiz?user_id=${userId}&skin_type=${skinDetail}&quiz_id=2',
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

    }catch(e){
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

  void submitQuestion(int optionId, int questionId){
    Map<String, dynamic> myObject = {
      'optionId': optionId,
      'questionId': questionId
    };
    _answersList.add(myObject);
    print(_answersList);
    notifyListeners();
  }

  void skinSelectedFlagTrue() {
    _skinSelectedFlag = true;
    print(_selectedOptionId);
    notifyListeners();
  }

  void selectedOptionIdChange(id) {
    _selectedOptionId = id;
  }
  Future<Map<String , dynamic>> fetchUserData(int userId) async {
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

     print('user id');
     print(userId);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String token = prefs.get('token');
    final response = await http.get('http://dermpro.herokuapp.com//api/v1/users/$userId',
      headers: {HttpHeaders.authorizationHeader: token},);
    if (response.statusCode == 200) {
      var finalResult =  jsonDecode(response.body);
      print('check result in skin model');
      print(finalResult);
      print(finalResult['data']['user']['user_quizes'].length);
      if(finalResult['data']['user']['user_quizes'].length != 0) {
        int index = finalResult['data']['user']['user_quizes'].length;
        Map<String ,
            dynamic> skinResult = finalResult['data']['user']['user_quizes'][index -
            1];
        print(skinResult);
        if (skinResult['completed'] == true) {
          if(skinResult['skin_type'] == 'Pale white skin'){
            _skinType = 'Pale white skin';
            _descriptions = firstType['description'];
            notifyListeners();
          }
          if(skinResult['skin_type'] == 'White skin'){
            _skinType = 'White skin';
            _descriptions = secondType['description'];
            notifyListeners();
          }
          if(skinResult['skin_type'] == 'Light brown skin'){
            _skinType = 'Light brown skin';
            _descriptions = thirdType['description'];
            notifyListeners();
          }
          if(skinResult['skin_type'] == 'Moderate brown skin'){
            _skinType = 'Moderate brown skin';
            _descriptions = fourthType['description'];
            notifyListeners();
          }
          if(skinResult['skin_type'] == 'Dark brown skin'){
            _skinType = 'Dark brown skin';
            _descriptions = fifthType['description'];
            notifyListeners();
          }
          if(skinResult['skin_type'] == 'Deeply pigmented dark brown to black skin'){
            _skinType = 'Deeply pigmented dark';
            _descriptions = sixthType['description'];
            notifyListeners();
          }

          _finalSkinResult = FinalSkinResult(type:skinType,description:descriptions);
          _skinTypeSurveyFlag = true;
          print("pakistan zindabad");
          notifyListeners();
          return {'completed':true};
        }
        print("some thing else");

        return {'completed':true};
      }
    } else {
      throw Exception('Failed to load album');
    }
  }
}
