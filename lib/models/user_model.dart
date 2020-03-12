import 'dart:io';

import 'package:flutter/material.dart';

class User {
  final int id;
  final String email;
  final String firstName;
  final String lastName;
  final String password;
  final String dob;
  final String phoneNumber;
  final String token;
  final String otp;
  final String image;


  User({
    @required this.id,
    @required this.email,
    @required this.firstName,
    @required this.lastName,
    @required this.password,
    @required this.dob,
    @required this.phoneNumber,
    @required this.token,
    @required this.otp,
    @required this.image,
  });

}