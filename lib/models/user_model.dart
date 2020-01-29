import 'package:flutter/material.dart';

class User {
  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final String password;
  final String dob;
  final String phoneNumber;
  final String verificationCode;
  final String token;


  User({
    @required this.id,
    @required this.email,
    @required this.firstName,
    @required this.lastName,
    @required this.password,
    @required this.dob,
    @required this.phoneNumber,
    @required this.verificationCode,
    @required this.token,
  });

}