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
  List<Questions> _finalQuestions;
  int _currentQuestionIndex = 0;
  Questions _currentQuestion;
  Answer _correctAnswer;
  List<Map<String, dynamic>> _answersList = [];

  bool _skinSelectedFlag = false;
  int _selectedOptionId = null;
  bool _requestSuccessFlag = true;
  bool _netWorkErrorFlag = false;

  List<Questions> get allQuestions {
    return List.from(_finalQuestions);
  }

  List<Answer> get allAnswers {
    return List.from(_answersList);
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
        'http://dermpro.herokuapp.com//api/v1/questions?quiz_id=1',
        headers: {HttpHeaders.authorizationHeader: token},
      );
      /* if (response.statusCode == 200 || response.statusCode == 201) {
      print("helo checking responce");
      print(response.body);
    }*/
      var finalData = json.decode(response.body);
      var questionList = finalData['data'];
      if (finalData['data']['success'] == true) {
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
        notifyListeners();
      }
      return null;
    } catch (error) {
      _requestSuccessFlag = false;
      Timer(Duration(seconds: 2), () {
        _skinFlag = false;
        _netWorkErrorFlag = true;
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
}
