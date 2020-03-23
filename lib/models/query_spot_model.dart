// To parse this JSON data, do
//
//     final querySpotModel = querySpotModelFromJson(jsonString);

import 'dart:convert';

QuerySpotModel querySpotModelFromJson(String str) => QuerySpotModel.fromJson(json.decode(str));

String querySpotModelToJson(QuerySpotModel data) => json.encode(data.toJson());

class QuerySpotModel {
  Data data;

  QuerySpotModel({
    this.data,
  });

  factory QuerySpotModel.fromJson(Map<String, dynamic> json) => QuerySpotModel(
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
  };
}

class Data {
  String message;
  User user;
  String authToken;
  bool success;
  String status;

  Data({
    this.message,
    this.user,
    this.authToken,
    this.success,
    this.status,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    message: json["message"],
    user: User.fromJson(json["user"]),
    authToken: json["auth_token"],
    success: json["success"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "user": user.toJson(),
    "auth_token": authToken,
    "success": success,
    "status": status,
  };
}

class User {
  int id;
  Email email;
  String passwordDigest;
  String createdAt;
  DateTime updatedAt;
  String gender;
  String dob;
  String contactNo;
  bool accountStatus;
  dynamic uid;
  bool socialLogIn;
  bool isActivated;
  String firstName;
  String lastName;
  String confirmationCode;
  Role role;
  String avatar;
  String confirmationToken;
  dynamic confirmedAt;
  DateTime confirmationSentAt;
  String fcmToken;
  bool numberVerified;
  List<QuerySpot> querySpots;

  User({
    this.id,
    this.email,
    this.passwordDigest,
    this.createdAt,
    this.updatedAt,
    this.gender,
    this.dob,
    this.contactNo,
    this.accountStatus,
    this.uid,
    this.socialLogIn,
    this.isActivated,
    this.firstName,
    this.lastName,
    this.confirmationCode,
    this.role,
    this.avatar,
    this.confirmationToken,
    this.confirmedAt,
    this.confirmationSentAt,
    this.fcmToken,
    this.numberVerified,
    this.querySpots,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    email: emailValues.map[json["email"]],
    passwordDigest: json["password_digest"],
    createdAt: json["created_at"],
    updatedAt: DateTime.parse(json["updated_at"]),
    gender: json["gender"],
    dob: json["dob"],
    contactNo: json["contact_no"],
    accountStatus: json["account_status"],
    uid: json["uid"],
    socialLogIn: json["SocialLogIn"],
    isActivated: json["is_activated"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    confirmationCode: json["confirmation_code"],
    role: roleValues.map[json["role"]],
    avatar: json["avatar"],
    confirmationToken: json["confirmation_token"],
    confirmedAt: json["confirmed_at"],
    confirmationSentAt: DateTime.parse(json["confirmation_sent_at"]),
    fcmToken: json["fcm_token"],
    numberVerified: json["number_verified"],
    querySpots: List<QuerySpot>.from(json["query_spots"].map((x) => QuerySpot.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": emailValues.reverse[email],
    "password_digest": passwordDigest,
    "created_at": createdAt,
    "updated_at": updatedAt.toIso8601String(),
    "gender": gender,
    "dob": dob,
    "contact_no": contactNo,
    "account_status": accountStatus,
    "uid": uid,
    "SocialLogIn": socialLogIn,
    "is_activated": isActivated,
    "first_name": firstName,
    "last_name": lastName,
    "confirmation_code": confirmationCode,
    "role": roleValues.reverse[role],
    "avatar": avatar,
    "confirmation_token": confirmationToken,
    "confirmed_at": confirmedAt,
    "confirmation_sent_at": confirmationSentAt.toIso8601String(),
    "fcm_token": fcmToken,
    "number_verified": numberVerified,
    "query_spots": List<dynamic>.from(querySpots.map((x) => x.toJson())),
  };
}

enum Email { DOCTOR_GMAIL_COM, SHAHIDHUMEED_GMAIL_COM }

final emailValues = EnumValues({
  "doctor@gmail.com": Email.DOCTOR_GMAIL_COM,
  "shahidhumeed@gmail.com": Email.SHAHIDHUMEED_GMAIL_COM
});

class QuerySpot {
  int id;
  Message message;
  String createdAt;
  List<String> images;
  int userId;
  String disease;
  String querySpotPlace;
  List<Feedback> feedbacks;

  QuerySpot({
    this.id,
    this.message,
    this.createdAt,
    this.images,
    this.userId,
    this.disease,
    this.querySpotPlace,
    this.feedbacks,
  });

  factory QuerySpot.fromJson(Map<String, dynamic> json) => QuerySpot(
    id: json["id"],
    message: json["message"] == null ? null : messageValues.map[json["message"]],
    createdAt: json["created_at"],
    images: List<String>.from(json["images"].map((x) => x)),
    userId: json["user_id"],
    disease: json["disease"] == null ? null : json["disease"],
    querySpotPlace: json["query_spot_place"],
    feedbacks: List<Feedback>.from(json["feedbacks"].map((x) => Feedback.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "message": message == null ? null : messageValues.reverse[message],
    "created_at": createdAt,
    "images": List<dynamic>.from(images.map((x) => x)),
    "user_id": userId,
    "disease": disease == null ? null : disease,
    "query_spot_place": querySpotPlace,
    "feedbacks": List<dynamic>.from(feedbacks.map((x) => x.toJson())),
  };
}

class Feedback {
  int id;
  String message;
  int querySpotId;
  String createdAt;
  DateTime updatedAt;
  String image;
  int userId;
  Role userRole;
  dynamic feedbackType;
  String querySpotPlace;
  Email userName;

  Feedback({
    this.id,
    this.message,
    this.querySpotId,
    this.createdAt,
    this.updatedAt,
    this.image,
    this.userId,
    this.userRole,
    this.feedbackType,
    this.querySpotPlace,
    this.userName,
  });

  factory Feedback.fromJson(Map<String, dynamic> json) => Feedback(
    id: json["id"],
    message: json["message"],
    querySpotId: json["query_spot_id"],
    createdAt: json["created_at"],
    updatedAt: DateTime.parse(json["updated_at"]),
    image: json["image"] == null ? null : json["image"],
    userId: json["user_id"],
    userRole: roleValues.map[json["user_role"]],
    feedbackType: json["feedback_type"],
    querySpotPlace: json["query_spot_place"] == null ? null : json["query_spot_place"],
    userName: emailValues.map[json["user_name"]],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "message": message,
    "query_spot_id": querySpotId,
    "created_at": createdAt,
    "updated_at": updatedAt.toIso8601String(),
    "image": image == null ? null : image,
    "user_id": userId,
    "user_role": roleValues.reverse[userRole],
    "feedback_type": feedbackType,
    "query_spot_place": querySpotPlace == null ? null : querySpotPlace,
    "user_name": emailValues.reverse[userName],
  };
}

enum Role { DOCTOR, PATIENT }

final roleValues = EnumValues({
  "doctor": Role.DOCTOR,
  "patient": Role.PATIENT
});

enum Message { HDJHXG, GXYDYFYFY, FHHFHFHFHFHF, SOLAR_LENTIGO, DISEASE }

final messageValues = EnumValues({
  "disease": Message.DISEASE,
  "fhhfhfhfhfhf": Message.FHHFHFHFHFHF,
  "gxydyfyfy": Message.GXYDYFYFY,
  "hdjhxg": Message.HDJHXG,
  "Solar Lentigo": Message.SOLAR_LENTIGO
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
