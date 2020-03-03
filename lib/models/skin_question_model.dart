class SkinType {
  Data data;

  SkinType({this.data});

  SkinType.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  String authToken;
  List<Questions> questions;
  bool success;
  String status;

  Data({this.authToken, this.questions, this.success, this.status});

  Data.fromJson(Map<String, dynamic> json) {
    authToken = json['auth_token'];
    if (json['questions'] != null) {
      questions = new List<Questions>();
      json['questions'].forEach((v) {
        questions.add(new Questions.fromJson(v));
      });
    }
    success = json['success'];
    status = json['status'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['auth_token'] = this.authToken;
    if (this.questions != null) {
      data['questions'] = this.questions.map((v) => v.toJson()).toList();
    }
    data['success'] = this.success;
    data['status'] = this.status;
    return data;
  }
}

class Questions {
  int id;
  String question;
  int quizId;
  int correctOption;
  List<Options> options;

  Questions(
      {this.id, this.question, this.quizId, this.correctOption, this.options});

  Questions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    question = json['question'];
    quizId = json['quiz_id'];
    correctOption = json['correct_option'];
    if (json['options'] != null) {
      options = new List<Options>();
      json['options'].forEach((v) {
        options.add(new Options.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['question'] = this.question;
    data['quiz_id'] = this.quizId;
    data['correct_option'] = this.correctOption;
    if (this.options != null) {
      data['options'] = this.options.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Options {
  int id;
  String option;
  bool correct;

  Options({this.id, this.option, this.correct});

  Options.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    option = json['option'];
    correct = json['correct'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['option'] = this.option;
    data['correct'] = this.correct;
    return data;
  }
}

class Answer{
  String optionId;
  String questionId;
  Answer({this.optionId,this.questionId});
 
}
class FinalSkinResult{
  String type;
  String description;
  FinalSkinResult({this.type,this.description});
}
